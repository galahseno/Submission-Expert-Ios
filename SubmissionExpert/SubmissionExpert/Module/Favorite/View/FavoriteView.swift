//
//  FavoriteView.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 05/03/24.
//

import SwiftUI
import Core
import Shared
import Favorite

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter<
        Any, GameModel, Interactor<
            Any, [GameModel], FavoriteGameRepository<GameLocalDataSource, GamesTranformer>>>

    var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    VStack {
                        Text("loading_text".localized())
                        ProgressView()
                    }
                } else if !presenter.errorMessage.isEmpty {
                    VStack {
                        Text(presenter.errorMessage)
                            .font(.headline)
                        Button {
                            self.presenter.getFavoriteGames()
                        } label: {
                            Label("retry".localized(), systemImage: "arrow.circlepath")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else if presenter.list.isEmpty {
                    VStack(alignment: .center) {
                        Image(systemName: "gamecontroller")
                            .resizable()
                            .frame(width: 75, height: 60)
                            .opacity(0.75)
                        Text("empty_favorite".localized())
                            .font(.title2)
                    }
                    .padding()
                } else {
                    List {
                        ForEach(
                            self.presenter.list,
                            id: \.id
                        ) { game in
                            self.linkBuilder(for: game.id) {
                                GameRowView(gameModel: game)
                            }
                        }
                    }
                }
            }
            .navigationTitle("favorite_games".localized())
            .onAppear {
                self.presenter.getFavoriteGames()
            }
        }
    }
}

extension FavoriteView {

    func linkBuilder<Content: View>(
        for id: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        NavigationLink(
            destination: DetailRouter().makeDetailView(for: id)
                .onDisappear {
                    self.presenter.getFavoriteGames()
                }
        ) { content() }
    }
}
