//
//  ContentView.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 04/03/24.
//

import SwiftUI
import Core
import Home
import Shared
import Search
import Favorite

struct ContentView: View {
    @State var showSplash: Bool = false

    var body: some View {
        ZStack {
            if self.showSplash {
                MainView()
            } else {
                SplashScreenView()

            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    self.showSplash = true
                }
            }
        }
    }
}

struct MainView: View {
    @EnvironmentObject var homePresenter: HomePresenter<
        Any, GameModel, Interactor<
            Any, [GameModel],
            HomeGamesRepository<HomeGamesRemoteDataSource, GamesTranformer>>>

    @EnvironmentObject var searchPresenter: SearchPresenter<
        GameModel, Interactor<
            String, [GameModel],
                SearchGamesRepository<SearchGamesRemoteDataSource, GamesTranformer>>>

    @EnvironmentObject var favoritePresenter: FavoritePresenter<
        Any, GameModel, Interactor<
            Any, [GameModel],
            FavoriteGameRepository<GameLocalDataSource, GamesTranformer>>>

    @State private var selection: TabEnum = .home

    var body: some View {
        TabView(selection: $selection) {
            HomeView(presenter: homePresenter)
                .tabItem {
                    Label("Home", systemImage: "swift")
                }
                .tag(TabEnum.home)

            SearchView(presenter: searchPresenter)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(TabEnum.search)

            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Label("Favorite", systemImage: "star.fill")
                }
                .tag(TabEnum.favorite)
        }
    }
}

struct SplashScreenView: View {
    var body: some View {
        Color.white
            .ignoresSafeArea()
        VStack(alignment: .center) {
            Image(uiImage: UIImage(imageLiteralResourceName: "rawg"))
                .resizable()
                .frame(width: 200, height: 200)
            Text("Rawg.io")
                .font(.title)
        }
    }
}
