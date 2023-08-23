//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 08.11.2023.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var viewModel: CharactersViewModel

    var columns: [GridItem] = [
        GridItem(.fixed(Constants.Constraints.cardWidth)),
        GridItem(.fixed(Constants.Constraints.cardWidth))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.characters, id: \.id) {
                    CharacterSection(
                        character: $0,
                        didSectionTapped: viewModel.presentProfileView
                    )
                    .frame(height: Constants.Constraints.cardHeight)
                }
            }
        }
        .background(Color(uiColor: Constants.Color.blackBG))
        .onAppear(perform: viewModel.loadCharacters)
    }
}
