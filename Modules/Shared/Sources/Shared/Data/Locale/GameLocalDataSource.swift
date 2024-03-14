//
//  FavoriteGameLocalDataSource.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Combine
import RealmSwift

public struct GameLocalDataSource : LocaleDataSource {

    public typealias Request = GameEntity

    public typealias Response = GameEntity

    private let realm: Realm

    public init(realm: Realm) {
        self.realm = realm
    }

    public func list() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            let games: Results<GameEntity> = {
                realm.objects(GameEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(games.toArray(ofType: GameEntity.self)))
        }.eraseToAnyPublisher()
    }

    public func add(entities: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in

            do {
                try self.realm.write {
                    self.realm.add(entities, update: .all)
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }

    public func delete(entities: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in

            do {
                let object = realm.objects(GameEntity.self).filter("id = %@", entities.id).first

                try realm.write {
                    if let obj = object {
                        realm.delete(obj)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }


    public func check(request: String?) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            guard let request  = request else { return completion(.failure(DatabaseError.requestFailed)) }

            let game: Results<GameEntity> = {
                self.realm.objects(GameEntity.self)
                    .filter("id == %@", request)
            }()

            if game.isEmpty {
                completion(.success(false))
            } else {
                completion(.success(true))
            }
        }.eraseToAnyPublisher()
    }
}
