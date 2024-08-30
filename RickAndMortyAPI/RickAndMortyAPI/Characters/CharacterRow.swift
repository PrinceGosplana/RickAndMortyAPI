//
//  CharacterRow.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 28.08.2024.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character

    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }

            Text(character.name)
                .font(.title3)
        }
    }
}
