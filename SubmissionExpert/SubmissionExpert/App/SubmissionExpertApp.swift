//
//  SubmissionExpertApp.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 04/03/24.
//

import SwiftUI
import Home
import Core
import Shared
import Search
import Favorite

let injection = Injection()

let homeUseCase: Interactor<
    Any,
    [GameModel],
    HomeGamesRepository<
        HomeGamesRemoteDataSource,
        GamesTranformer>
> = injection.provideHome()

let searchUseCase: Interactor<
    String,
    [GameModel],
    SearchGamesRepository<
        SearchGamesRemoteDataSource,
        GamesTranformer>
> = injection.provideSearch()

let favoriteUseCase: Interactor<
    Any,
    [GameModel],
    FavoriteGameRepository<
        GameLocalDataSource,
        GamesTranformer>
> = injection.provideFavorite()

@main
struct SubmissionExpertApp: App {
    let homePresenter = HomePresenter(useCase: homeUseCase)
    let searchPresenter = SearchPresenter(useCase: searchUseCase)
    let favoritePresenter = FavoritePresenter(useCase: favoriteUseCase)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(searchPresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
