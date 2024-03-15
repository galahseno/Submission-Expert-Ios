//
//  HomeView.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 04/03/24.
//

import SwiftUI
import Home
import Core
import Shared

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter<
        Any, GameModel, Interactor<
            Any, [GameModel], HomeGamesRepository<HomeGamesRemoteDataSource, GamesTranformer>>>

    @State private var showingProfile = false

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
                            self.presenter.getGames()
                        } label: {
                            Label("retry".localized(), systemImage: "arrow.circlepath")
                        }
                        .buttonStyle(.borderedProminent)
                    }
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
                        .navigationTitle("top_games".localized())
                    }
                    .toolbar {
                        Button {
                            showingProfile.toggle()
                        } label: {
                            Label("profile".localized(), systemImage: "person.crop.circle")
                        }
                    }
                    .sheet(isPresented: $showingProfile) {
                        Profile()
                    }
                }
            }.onAppear {
                if self.presenter.list.count == 0 {
                    self.presenter.getGames()
                }
            }
        }
    }
}

extension HomeView {

    func linkBuilder<Content: View>(
        for id: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        NavigationLink(
            destination: DetailRouter().makeDetailView(for: id)
        ) { content() }
    }
}
