//
//  CharacterSection.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 08.11.2023.
//

import SwiftUI

struct CharacterSection: View {
    var defaultURL = URL(string: "https://bogatyr.club/uploads/posts/2021-11/thumbs/1636951185_1-bogatyr-club-p-polnostyu-chyornii-fon-bez-nichego-1.jpg")
    var defaultText = "Rick Sanchez"

    var body: some View {
        VStack {
            CharacterImageView(imageURL: defaultURL)

            Text(defaultText)
                .font(SwiftUIConstants.Fonts.characterCardName)
                .foregroundColor(.white)
                .frame(height: Constants.Constraints.cardTitleHeight)
                .padding(16)
        }
        .background(Color(uiColor: Constants.Color.blackCard))
        .cornerRadius(Constants.CornerRadius.cellCard)
    }
}

#Preview {
    CharacterSection()
}
