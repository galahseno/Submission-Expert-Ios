//
//  DetailRouter.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 13/03/24.
//

import SwiftUI
import Core
import Detail
import Shared

class DetailRouter {

    func makeDetailView(for id: String) -> some View {
        let detailUseCase: Interactor<
            String,
            GameDetail,
            DetailGameRepository<
                DetailGameRemoteDataSource,
                DetailTranformer>
        > = injection.provideDetail(id: id)

        let checkFavoriteUseCase: Interactor<
            String,
            Bool,
            CheckGameRepository<
                GameLocalDataSource>
        > = injection.provideCheckFavorite()

        let addFavoriteUseCase: Interactor<
            GameModel,
            Bool,
            AddGameRepository<
                GameLocalDataSource,
                GameTranformer>
        > = injection.provideAddFavorite()

        let deleteFavoriteUseCase: Interactor<
            GameModel,
            Bool,
            DeleteGameRepository<
                GameLocalDataSource,
                GameTranformer>
        > = injection.provideDeleteFavorite()

        let presenter = DetailPresenter(
            detailUseCase: detailUseCase, checkFavoriteUseCase: checkFavoriteUseCase,
            addFavoriteUseCase: addFavoriteUseCase,
            deletefavoriteUseCase: deleteFavoriteUseCase)

       return GameDetailView(presenter: presenter, id: id)
    }
}
