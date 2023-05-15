//
//  CoreDataManager.swift
//  DeezerCase
//
//  Created by Onur Duyar on 13.05.2023.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DeezerApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func saveTrackToFavorites(track: Track) {
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteTrack", in: context)!
        let favoriteTrack = NSManagedObject(entity: entity, insertInto: context)
        favoriteTrack.setValue(track.title, forKey: "title")
        favoriteTrack.setValue(track.id, forKey: "id")
        favoriteTrack.setValue(track.albumCover, forKey: "album")
        favoriteTrack.setValue(track.duration, forKey: "duration")
        favoriteTrack.setValue(track.preview, forKey: "previewUrl")
        favoriteTrack.setValue(track.isLike, forKey: "isLike")
        do {
            try context.save()
            print("Track saved to favorites.")
        } catch let error as NSError {
            print("Could not save track to favorites. \(error), \(error.userInfo)")
        }
    }
    
    func deleteTrackFromFavorites(id: Int?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteTrack")

        guard let id else{return}
        let predicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count != 0 {
                if let managedObject = result[0] as? NSManagedObject {
                    context.delete(managedObject)
                    do {
                        try context.save()
                    }
                    catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    func getFavoriteTracks() -> [Track]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteTrack")
        do {
            let results = try context.fetch(fetchRequest)
            let tracks = results.compactMap { result -> Track? in
                guard let title = (result as AnyObject).value(forKey: "title") as? String,
                      let id = (result as AnyObject).value(forKey: "id") as? Int,
                      let albumCover = (result as AnyObject).value(forKey: "album") as? String,
                      let duration = (result as AnyObject).value(forKey: "duration") as? Int,
                      let isLike = (result as AnyObject).value(forKey: "isLike") as? Bool,
                      let previewUrl = (result as AnyObject).value(forKey: "previewUrl") as? String else {
                    return nil
                }
                return Track(id: id, readable: nil, title: title, titleShort: nil, titleVersion: nil, isrc: nil, link: nil, duration: duration, trackPosition: nil, diskNumber: nil, rank: nil, explicitLyrics: nil, explicitContentLyrics: nil, explicitContentCover: nil, preview: previewUrl, artist: nil, type: nil,isLike: isLike, albumCover: albumCover)
            }
            return tracks
        } catch let error as NSError {
            print("Could not fetch favorite tracks. \(error), \(error.userInfo)")
            return nil
        }
    }
}
