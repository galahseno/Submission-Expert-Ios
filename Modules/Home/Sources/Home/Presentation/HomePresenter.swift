//
//  GetListPresenter.swift
//
//
//  Created by Galah Seno on 12/03/24.
//

import Foundation
import Combine
import Core

public class HomePresenter<
    Request,
    Response,
    Interactor: UseCase
>: ObservableObject where
  Interactor.Request == Request,
  Interactor.Response == [Response]
{

    private var cancellables: Set<AnyCancellable> = []

    private let useCase: Interactor

    @Published public var list: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false

    public init(useCase: Interactor) {
        self.useCase = useCase
    }

    public func getGames() {
        isLoading = true
        self.useCase.execute(request: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
}
