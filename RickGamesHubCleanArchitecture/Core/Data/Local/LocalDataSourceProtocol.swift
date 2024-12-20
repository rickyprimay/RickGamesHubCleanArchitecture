//
//  LocalDataSourceProtocol.swift
//  RickGamesHubCleanArchitecture
//
//  Created by Ricky Primayuda Putra on 20/12/24.
//

import CoreData

protocol LocalDataSourceProtocol: AnyObject {
    func fetchEntities<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate?) -> Result<[T], Error>
    func saveContext() throws
    func deleteEntity(_ entity: NSManagedObject) throws
    func addFavorite(game: GameModel, completion: @escaping (Result<Void, Error>) -> Void)
    func removeFavorite(gameID: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func isFavorite(gameID: Int, completion: @escaping (Result<Bool, Error>) -> Void)
    func getFavorites(completion: @escaping (Result<[GameModel], Error>) -> Void)
}

final class LocalDataSource: NSObject {
    static let instance = LocalDataSource()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RickGamesHub")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores{_, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func fetchEntities<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate? = nil) -> Result<[T], Error> {
        let request = T.fetchRequest()
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [T] else {
                return .failure(NSError(domain: "Invalid Entity Type", code: 0, userInfo: nil))
            }
            return .success(results)
        } catch {
            return .failure(error)
        }
    }
    
    func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func deleteEntity(_ entity: NSManagedObject) throws {
        context.delete(entity)
        try saveContext()
    }

    func addFavorite(game: GameModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let favorite = FavoritesGames(context: context)
        favorite.id = Int32(game.id)
        favorite.name = game.name
        favorite.backgroundImage = game.backgroundImageURL?.absoluteString
        favorite.rating = game.rating
        favorite.released = game.released
        
        game.screenshots.forEach { screenshot in
            if let screenshotURL = screenshot.screenShotURL {
                let screenshot = ShortScreenshots(context: context)
                screenshot.image = screenshotURL.absoluteString
                screenshot.games = favorite
            }
        }

        do {
            try saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func removeFavorite(gameID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<FavoritesGames> = FavoritesGames.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", gameID)
        
        do {
            let items = try context.fetch(fetchRequest)
            items.forEach { context.delete($0) }
            try saveContext()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func isFavorite(gameID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritesGames")
        fetchRequest.predicate = NSPredicate(format: "id == %d", gameID)
        
        do {
            let count = try context.count(for: fetchRequest)
            completion(.success(count > 0))
        } catch {
            completion(.failure(error))
        }
    }

    func getFavorites(completion: @escaping (Result<[GameModel], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<FavoritesGames> = FavoritesGames.fetchRequest()
        do {
            let favorites = try context.fetch(fetchRequest)
            let gameModels = favorites.map { favorite in
                GameModel(
                    id: Int(favorite.id),
                    name: favorite.name ?? "",
                    backgroundImageURL: URL(string: favorite.backgroundImage ?? ""),
                    rating: favorite.rating,
                    released: favorite.released ?? "",
                    screenshots: (favorite.shortScreenshots?.allObjects as? [ShortScreenshots])?.compactMap { screenshot in
                        Screenshot(image: screenshot.image ?? "")
                    } ?? []
                )
            }
            completion(.success(gameModels))
        } catch {
            print("Error fetching favorites: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
