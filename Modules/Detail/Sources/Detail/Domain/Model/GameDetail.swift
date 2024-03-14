//
//  GameDetailMod.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation

public struct GameDetail {

    public let id: String
    public let name: String
    public let released: String
    public let backgroundImage: String
    public let website: String
    public let rating: Double
    public let developers, genres: [String]
    public let descriptionRaw: String

}
