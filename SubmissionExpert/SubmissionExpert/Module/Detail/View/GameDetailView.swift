//
//  GameDetail.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 05/03/24.
//

import SwiftUI
import CachedAsyncImage
import Detail
import Shared
import Core

struct GameDetailView: View {
    @ObservedObject var presenter: DetailPresenter<
        Interactor<String, GameDetail, DetailGameRepository<DetailGameRemoteDataSource, DetailTranformer>>,
            Interactor<String, Bool, CheckGameRepository<GameLocalDataSource>>,
            Interactor<GameModel, Bool, AddGameRepository<GameLocalDataSource, GameTranformer>>,
            Interactor<GameModel, Bool, DeleteGameRepository<GameLocalDataSource, GameTranformer>>>

    @Environment(\.openURL) private var openURL

    var id: String
    @State var shareImage: Image?

    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ProgressView()
                }
            } else if !presenter.errorMessage.isEmpty {
                VStack {
                    Text(presenter.errorMessage)
                        .font(.headline)
                    Button {
                        self.presenter.getDetailGames(request: id)
                    } label: {
                        Label("Retry", systemImage: "arrow.circlepath")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else if presenter.game != nil {
                ScrollView {
                    VStack(alignment: .center) {
                        gameName
                        detailImage
                        ratingAndReleased

                        if !presenter.game!.genres.isEmpty {
                            genres
                        }

                        if !presenter.game!.developers.isEmpty {
                            developers
                        }

                        descriptionRaw

                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        presenter.favoriteState ? presenter.deleteFavorite() : presenter.addFavorite()
                    } label: {
                        Label("Favorite", systemImage: presenter.favoriteState ?
                              "heart.circle.fill" : "heart.circle")
                    }
                    Button {
                        openURL(URL(string: presenter.game!.website)!)
                    } label: {
                        Label("Web", systemImage: "globe")
                    }
                    if shareImage != nil {
                        ShareLink(
                            item: shareImage!,
                            subject: Text("Cool Photo"),
                            message: Text("Check it out!"),
                            preview: SharePreview(
                                presenter.game!.name,
                                image: shareImage!))
                    }
                }
            }
        }.onAppear {
            if self.presenter.game == nil {
                self.presenter.getDetailGames(request: id)
            }
        }
    }
}

extension GameDetailView {

    var gameName: some View {
        Text(presenter.game!.name)
            .font(.headline)
            .lineLimit(3)
    }

    var detailImage: some View {
        CachedAsyncImage(url: URL(string: presenter.game!.backgroundImage)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 250, height: 200)
                .onAppear {
                    self.shareImage = image
                }
        } placeholder: {
            ProgressView()
                .frame(maxWidth: 100, alignment: .center)
        }
        .cornerRadius(10)
    }

    var ratingAndReleased: some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(presenter.game!.rating))
                    .font(.subheadline)
            }
            Spacer()
            Text("Releasaed : \(presenter.game!.released)")
                .font(.subheadline)
        }
        .padding(
            EdgeInsets(
                top: 8,
                leading: 24,
                bottom: 0,
                trailing: 24
            ))
    }

    var genres: some View {
        VStack {
            Text("Genres :")
                .font(.subheadline)
            Text(presenter.game!.genres.joined(separator: ", "))
                .font(.subheadline)
        }
        .padding(
            EdgeInsets(
                top: 4,
                leading: 8,
                bottom: 0,
                trailing: 8
            ))
    }

    var developers: some View {
        VStack {
            Text("Developers :")
                .font(.subheadline)
            Text(presenter.game!.developers.joined(separator: ", "))
                .font(.subheadline)
        }
        .padding(
            EdgeInsets(
                top: 4,
                leading: 8,
                bottom: 0,
                trailing: 8
            ))
    }

    var descriptionRaw: some View {
        Text(presenter.game!.descriptionRaw)
            .font(.subheadline)
            .padding()
    }
}
