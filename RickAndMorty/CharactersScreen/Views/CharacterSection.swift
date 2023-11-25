//
//  CharacterSection.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 08.11.2023.
//

import SwiftUI

struct CharacterSection: View {
    var character: Character
    var didSectionTapped: (Character) -> Void

    var body: some View {
        VStack(spacing: 0) {
            CharacterImageView(imageURL: URL(string:character.image ?? ""))

            Text(character.name)
                .font(Constants.Fonts.characterCardName)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .frame(height: Constants.Constraints.cardTitleHeight)
                .padding(16)
        }
        .background(Color(uiColor: Constants.Color.blackCard))
        .cornerRadius(Constants.CornerRadius.cellCard)
        .onTapGesture {
            self.didSectionTapped(character)
        }
    }
}
