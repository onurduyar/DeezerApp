//
//  FavoritesViewModel.swift
//  DeezerCase
//
//  Created by Onur Duyar on 13.05.2023.
//

import Foundation
import CoreData

final class FavoritesViewModel{
    
    static let shared = FavoritesViewModel()
    var favorites: [Track]? = [Track]()
    
   
    func addToFavorites(track: Track?) {
        guard let track,let favorites else {return}
        guard !favorites.contains(where: { $0.id == track.id }) else { return }
        self.favorites?.append(track)
        CoreDataManager.shared.saveTrackToFavorites(track: track)
    }
    func deleteFromFavorites(_ track: Track?){
        
        guard let track else {return}
        favorites?.removeAll { element in
            element.id == track.id
        }
        CoreDataManager.shared.deleteTrackFromFavorites(id: track.id)
    }
}
