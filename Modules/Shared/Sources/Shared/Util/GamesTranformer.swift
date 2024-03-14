//
//  SharedTransformer.swift
//
//
//  Created by Galah Seno on 12/03/24.
//

import Core
import Foundation

public struct GamesTranformer: Mapper {

    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameModel]

    public init() {}

    public func transformResponseToDomain(response: [GameResponse]) -> [GameModel] {
        return response.map { result in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateNow = dateFormatter.string(from: Date())

            return GameModel(
                id: String(result.id ?? 0),
                name: result.name ?? "Unknown",
                rating: result.rating ?? 0.0,
                backgroundImage: result.backgroundImage
                ?? "https://www.codespeedy.com/wp-content/uploads/2019/03/Chrome-Broken-Image-Icon.png",
                released: result.released ?? dateNow
            )
        }
    }

    public func transformDomainToEntity(domain: [GameModel]) -> Entity {
        fatalError()
    }

    public func transformEntityToDomain(entity: [GameEntity]) -> [GameModel] {
        return entity.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                rating: result.rating,
                backgroundImage: result.backgroundImage,
                released: result.released
            )
        }
    }
}
