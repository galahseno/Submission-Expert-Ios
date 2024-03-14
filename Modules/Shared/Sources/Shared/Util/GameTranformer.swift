//
//  FavoriteTranformer.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core

public struct GameTranformer: Mapper {
    
    public typealias Response = Any
    public typealias Entity = GameEntity
    public typealias Domain = GameModel
    
    public init() {}
    
    public func transformResponseToDomain(response: Response) -> GameModel {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: GameModel) -> GameEntity {
        let newGame = GameEntity()
        newGame.id = domain.id
        newGame.name = domain.name
        newGame.rating = domain.rating
        newGame.released = domain.released
        newGame.backgroundImage = domain.backgroundImage
        
        return newGame
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameModel {
        fatalError()
    }
}
