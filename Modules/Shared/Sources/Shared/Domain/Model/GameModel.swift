//
//  GameModel.swift
//  
//
//  Created by Galah Seno on 12/03/24.
//

import Foundation

public struct GameModel: Equatable, Identifiable {

    public let id: String
    public let name: String
    public let rating: Double
    public let backgroundImage: String
    public let released: String
    
    public init(id: String, name: String, rating: Double, backgroundImage: String, released: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.released = released
    }
}
