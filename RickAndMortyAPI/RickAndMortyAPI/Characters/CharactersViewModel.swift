//
//  CharactersViewModel.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 28.08.2024.
//

import Combine
import SwiftUI

enum FetchType {
    case urlSession, combine, asyncAwait
}

@MainActor
final class CharactersViewModel: ObservableObject {

    @Published var characters: [Character] = []
    var networkService = NetworkServiceCombine()
    let networkURLService = NetworkServiceURLSession()
    var subscriptions = Set<AnyCancellable>()


    func fetchCharacters(with type: FetchType) {
        switch type {
        case .urlSession:
            fetchCharactersWithURLSession()
        case .combine:
            fetchCharactersWithCombine()
        case .asyncAwait:
            Task {
                await fetchCharactersWithAsyncAwait()
            }
        }
    }

    private func fetchCharactersWithURLSession() {
        networkURLService.fetchCharacters { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newCharacters):
                    self.characters = newCharacters
                case .failure:
                    self.characters = []
                }
            }
        }
    }

    private func fetchCharactersWithCombine() {

        characters.removeAll()
        
        NetworkServiceCombine.fetch()
            .sink { [unowned self] item in
                characters.append(contentsOf: item.results)
            }
            .store(in: &subscriptions)
    }

    private func fetchCharactersWithAsyncAwait() async {
        characters.removeAll()
        characters = await NetworkServiceAsyncAwait().fetchCharacters()
    }
}
