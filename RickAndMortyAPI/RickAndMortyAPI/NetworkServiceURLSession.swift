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
                completion(.success([]))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
