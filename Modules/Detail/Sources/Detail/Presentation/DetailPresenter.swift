//
//  DetailModulePresenter.swift
//
//
//  Created by Galah Seno on 13/03/24.
//

import Foundation
import Core
import Combine
import Shared

public class DetailPresenter<
    DetailUseCase: UseCase,
    CheckFavoriteUseCase: UseCase,
    AddFavoriteUseCase: UseCase,
    DeleteFavoriteUseCase: UseCase
>: ObservableObject where
  DetailUseCase.Request == String,
  DetailUseCase.Response == GameDetail,
  CheckFavoriteUseCase.Request == String,
  CheckFavoriteUseCase.Response == Bool,
  AddFavoriteUseCase.Request == GameModel,
  AddFavoriteUseCase.Response == Bool,
  DeleteFavoriteUseCase.Request == GameModel,
  DeleteFavoriteUseCase.Response == Bool
{

    private var cancellables: Set<AnyCancellable> = []

    private let detailUseCase: DetailUseCase
    private let checkFavoriteUseCase: CheckFavoriteUseCase
    private let addFavoriteUseCase: AddFavoriteUseCase
    private let deletefavoriteUseCase: DeleteFavoriteUseCase
    private var gameModel: GameModel?

    @Published public var game: GameDetail?
    @Published public var errorMessage: String = ""
    @Published public var loadingState: Bool = false
    @Published public var favoriteState: Bool = false

    public init(
        detailUseCase: DetailUseCase, checkFavoriteUseCase: CheckFavoriteUseCase,
        addFavoriteUseCase: AddFavoriteUseCase, deletefavoriteUseCase: DeleteFavoriteUseCase
    ) {
        self.detailUseCase = detailUseCase
        self.checkFavoriteUseCase = checkFavoriteUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.deletefavoriteUseCase = deletefavoriteUseCase
    }

    public func getDetailGames(request: DetailUseCase.Request) {
        loadingState = true
        detailUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.loadingState = false
                case .finished:
                    self.loadingState = false
                    self.checkFavorite(request: request)
                }
            }, receiveValue: { game in
                self.game = game
                self.gameModel = GameModel(
                    id: game.id,
                    name: game.name,
                    rating: game.rating,
                    backgroundImage: game.backgroundImage,
                    released: game.released
                )
            })
            .store(in: &cancellables)
    }

    private func checkFavorite(request: CheckFavoriteUseCase.Request) {
        checkFavoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { favorite in
                self.favoriteState = favorite
            })
            .store(in: &cancellables)
    }

    public func addFavorite() {
        guard let game = gameModel else { return }
        addFavoriteUseCase.execute(request: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.favoriteState = true
                }
            }, receiveValue: { _ in
                self.favoriteState = true
            })
            .store(in: &cancellables)
    }

    public func deleteFavorite() {
        guard let game = gameModel else { return }
        deletefavoriteUseCase.execute(request: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.favoriteState = false
                }
            }, receiveValue: { _ in
                self.favoriteState = false
            })
            .store(in: &cancellables)
    }

}
