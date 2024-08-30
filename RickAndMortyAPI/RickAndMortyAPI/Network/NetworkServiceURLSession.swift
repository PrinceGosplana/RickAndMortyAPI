//
//  NetworkServiceURLSession.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 30.08.2024.
//

import Foundation

final class NetworkServiceURLSession {

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            // I don't want to handle error, this is not the goal of this project
            if error != nil{
                completion(.success([]))
            }

            guard let data else {
                completion(.success([]))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(CharacterResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodeData.results))
                }
            } catch {
                // I don't want to handle error, this is not the goal of this project
                completion(.success([]))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
