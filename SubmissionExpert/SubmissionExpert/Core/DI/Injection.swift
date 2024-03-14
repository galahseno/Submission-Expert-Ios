//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 04/03/24.
//

import Foundation
import RealmSwift
import Core
import Home
import Shared
import Search
import Favorite
import Detail

final class Injection: NSObject {

    private let realm = try? Realm()

    func provideHome<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModel] {
        let remote = HomeGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)
        let mapper = GamesTranformer()

        let repository = HomeGamesRepository(
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
        let remote = SearchGamesRemoteDataSource(endpoint: Endpoints.Gets.search.url)
        let mapper = GamesTranformer()

        let repository = SearchGamesRepository(
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideDetail<U: UseCase>(id: String) -> U where U.Request == String, U.Response == GameDetail {
        let remote = DetailGameRemoteDataSource(endpoint: Endpoints.Gets.detail(id: id).url)
        let mapper = DetailTranformer()

        let repository = DetailGameRepository(
            remoteDataSource: remote,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideCheckFavorite<U: UseCase>() -> U where U.Request == String, U.Response == Bool {
        let locale = GameLocalDataSource(realm: realm!)

        let repository = CheckGameRepository(
            localDataSource: locale)

        return (Interactor(repository: repository) as? U)!
    }

    func provideAddFavorite<U: UseCase>() -> U where U.Request == GameModel, U.Response == Bool {
        let locale = GameLocalDataSource(realm: realm!)
        let mapper = GameTranformer()

        let repository = AddGameRepository(
            localDataSource: locale,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideDeleteFavorite<U: UseCase>() -> U where U.Request == GameModel, U.Response == Bool {
        let locale = GameLocalDataSource(realm: realm!)
        let mapper = GameTranformer()

        let repository = DeleteGameRepository(
            localDataSource: locale,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }

    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModel] {
        let locale = GameLocalDataSource(realm: realm!)
        let mapper = GamesTranformer()

        let repository = FavoriteGameRepository(
            localDataSource: locale,
            mapper: mapper)

        return (Interactor(repository: repository) as? U)!
    }
}
