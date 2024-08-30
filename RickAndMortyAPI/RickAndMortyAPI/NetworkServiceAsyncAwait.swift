//
//  NetworkServiceAsyncAwait.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 30.08.2024.
//

import Foundation

actor NetworkServiceAsyncAwait {

    func fetchCharacters() async -> [Character] {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return [] }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(CharacterResponse.self, from: data)
            return decodedData.results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
