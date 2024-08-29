//
//  NetworkServiceCombine.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 29.08.2024.
//

import Combine
import Foundation

@Observable
final class NetworkServiceCombine {

    static func fetch() -> AnyPublisher<CharacterResponse, Never> {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CharacterResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .replaceError(with: CharacterResponse.init(results: []))
            .eraseToAnyPublisher()
    }
}
