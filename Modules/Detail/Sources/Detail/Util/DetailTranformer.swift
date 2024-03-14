//
//  DetailTranformer.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Shared

public struct DetailTranformer: Mapper {
    public typealias Response = GameDetailResponse
    public typealias Entity = Any
    public typealias Domain = GameDetail
    
    public init() {}
    
    public func transformResponseToDomain(response: GameDetailResponse) -> GameDetail {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateNow = dateFormatter.string(from: Date())
        let website = response.website!.isEmpty ? "https://www.google.com/" : response.website!

        return GameDetail(
            id: String(response.id ?? 0),
            name: response.name ?? "Unknown",
            released: response.released ?? dateNow,
            backgroundImage: response.backgroundImage
            ?? "https://www.codespeedy.com/wp-content/uploads/2019/03/Chrome-Broken-Image-Icon.png",
            website: website,
            rating: response.rating ?? 0.0,
            developers: response.developers.map { developer in
                developer.name ?? "Unknown"
            },
            genres: response.genres.map { genre in
                genre.name ?? "Unknown"
            },
            descriptionRaw: response.descriptionRaw ?? "Unknown"
        )
    }
    
    public func transformDomainToEntity(domain: GameDetail) -> Entity {
        fatalError()
    }
    
    public func transformEntityToDomain(entity: Entity) -> GameDetail {
        fatalError()
    }
}
