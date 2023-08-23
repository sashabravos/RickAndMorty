//
//  EpisodeSection.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 07.11.2023.
//

import SwiftUI

struct EpisodeSection: View {
    var episodeModel: Episode

    var body: some View {
        VStack(alignment: .leading) {
            Text(episodeModel.name)
                .font(SwiftUIConstants.Fonts.titleSecondary)
                .foregroundColor(Color(uiColor: Constants.Color.white))
            Spacer()

            HStack {
                Text(episodeModel.episode?.convertToEpisodeTitle() ?? "")
                    .font(SwiftUIConstants.Fonts.descriptionLeft)
                    .foregroundColor(Color(uiColor: Constants.Color.primary))
                Spacer()

                Text(episodeModel.airDate ?? "")
                    .font(SwiftUIConstants.Fonts.descriptionRight)
                    .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 86.0)
        .background(Color(uiColor: Constants.Color.blackCard))
        .cornerRadius(Constants.CornerRadius.profileAnyCard)
    }
}
