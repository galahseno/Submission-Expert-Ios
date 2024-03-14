//
//  GameDetailResponse.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation

public struct GameDetailResponse: Decodable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let website: String?
    let rating: Double?
    let developers, genres: [Developer]
    let descriptionRaw: String?

    enum CodingKeys: String, CodingKey {
        case id, name, released, website, rating, developers, genres
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
    }
}

public struct Developer: Codable {
    let name: String?
}
