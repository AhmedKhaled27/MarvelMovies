//
//  MoviesLocalDataService.swift
//  MarvelMoviesApp
//
//  Created by Ahmed Khaled on 29/11/2023.
//

import Foundation
import CoreData

class MoviesLocalDataService {
    
    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension MoviesLocalDataService: MoviesLocalDataServiceProtocol {
    func fetchMovieById(_ id: Int,
                        completionHandler: @escaping (Result<MovieDetails, Error>) -> Void) {
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest: NSFetchRequest<MovieDetailsEntity> = MovieDetailsEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", id)
                guard let requestEntity = try context.fetch(fetchRequest).first else {
                    completionHandler(.failure(CoreDataStorageError.readError("Found no movie with given id")))
                    return
                }
                completionHandler(.success(requestEntity.toDomain()))
            } catch {
                completionHandler(.failure(CoreDataStorageError.readError(error)))
            }
        }
                
    }
    
    func saveMovieDetails(movieDetails: MovieDetailsData) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let _ = movieDetails.toEntity(in: context)
                try context.save()
            } catch {
                debugPrint("MoviesLocalDataService Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
}
