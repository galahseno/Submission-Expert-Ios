//
//  SearchView.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 05/03/24.
//

import SwiftUI
import Core
import Search
import Shared

struct SearchView: View {
    @ObservedObject var presenter: SearchPresenter<
        GameModel, Interactor<
            String, [GameModel],
            SearchGamesRepository<SearchGamesRemoteDataSource, GamesTranformer>>>

    var body: some View {
        NavigationStack {
            ZStack {
                if presenter.isLoading {
                    VStack {
                        Text("Loading...")
                        ProgressView()
                    }
                } else if !presenter.errorMessage.isEmpty {
                    VStack {
                        Text(presenter.errorMessage)
                            .font(.headline)
                        Button {
                            self.presenter.search()
                        } label: {
                            Label("Retry", systemImage: "arrow.circlepath")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else if presenter.list.isEmpty {
                    VStack(alignment: .center) {
                        Image(systemName: "gamecontroller.fill")
                            .resizable()
                            .frame(width: 75, height: 60)
                            .opacity(0.75)
                        Text("Search your Games")
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
            .navigationTitle("Search Games")
            .searchable(text: $presenter.keyword)
            .onSubmit(of: .search) {
                self.presenter.search()
            }
        }
    }
}

extension SearchView {

    func linkBuilder<Content: View>(
        for id: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        NavigationLink(
            destination: DetailRouter().makeDetailView(for: id)
        ) { content() }
    }
}
