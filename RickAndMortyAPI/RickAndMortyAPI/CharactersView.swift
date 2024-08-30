//
//  ContentView.swift
//  RickAndMortyAPI
//
//  Created by Oleksandr Isaiev on 26.08.2024.
//

import SwiftUI

struct CharactersView: View {

    @StateObject private var viewModel = CharactersViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                List(viewModel.characters) {
                    CharacterRow(character: $0)
                }
            }
            .task {
                viewModel.fetchCharacters()
//                viewModel.fetchCharactersWithCombine()
//                await viewModel.fetchCharactersWithAsyncAwait()
            }
            .navigationTitle("Rick and Morty")
        }
    }
}

#Preview {
    CharactersView()
}
