//
//  GamesResponse.swift
//
//
//  Created by Galah Seno on 12/03/24.
//

import Foundation

public struct GamesResponse: Decodable {

    public let games: [GameResponse]

    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}

public struct GameResponse: Decodable {
    public let id: Int?
    public let name: String?
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
    }
}
