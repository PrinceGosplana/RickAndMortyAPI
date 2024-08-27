//
//  Character.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 27.08.2024.
//

import SwiftUI

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let image: URL
}
