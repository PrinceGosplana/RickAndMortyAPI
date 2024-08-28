//
//  CharactersViewModel.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 28.08.2024.
//

import SwiftUI
//import Observation
//
//@Observable
@MainActor
final class CharactersViewModel: ObservableObject {

    @Published var characters: [Character] = []

    func fetchCharacters() {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        characters.append(Character(id: 1, name: "N", image: url))

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                return
            }

            guard let data else { return }

            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    self.characters = decodeData.results
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
