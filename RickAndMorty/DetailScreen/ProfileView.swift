//
//  ProfileView.swift
//  SwiftUISheets
//
//  Created by Александра Кострова on 02.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        ScrollView {
            CharacterImageView(
                imageURL: URL(
                    string: viewModel.character.image ?? ""
                )
            )

            Text(viewModel.character.name)
                .font(Constants.Fonts.profileName)
                .foregroundColor(Color(uiColor: Constants.Color.white))
                .padding(8)

            Text(viewModel.character.status ?? StringConstants.noInfo)
                .font(Constants.Fonts.stateOfLife)
                .foregroundColor(Color(uiColor: Constants.Color.primary))
                .padding(8)

            infoStackSection
            originStackSection
            episodesStackSection
        }
        .padding(8)
        .background(Color(uiColor: Constants.Color.blackBG))
        .onAppear(perform: viewModel.getCharacterEpisodes)
    }

    // MARK: - InfoStackSection -
    var infoStackSection: some View {
        Section(header: Text(.info)
            .font(Constants.Fonts.titleSecondary)
            .foregroundColor(Color(uiColor: Constants.Color.white))
            .padding(8)
            .frame(maxWidth: .infinity)) {

                VStack {
                    HStack(alignment: .bottom) {
                        Text(.species)
                            .font(Constants.Fonts.features)
                            .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
                        Spacer()
                        Text(viewModel.character.species ?? StringConstants.noInfo)
                            .font(Constants.Fonts.features)
                            .foregroundColor(Color(uiColor: Constants.Color.white))
                    }
                    Spacer()

                    HStack(alignment: .bottom) {
                        Text(.type)
                            .font(Constants.Fonts.features)
                            .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
                        Spacer()
                        Text(
                            (viewModel.character.type == "") ? StringConstants.noInfo : viewModel.character.type ?? StringConstants.noInfo
                        )
                        .font(Constants.Fonts.features)
                        .foregroundColor(Color(uiColor: Constants.Color.white))
                    }
                    Spacer()

                    HStack(alignment: .bottom) {
                        Text(.gender)
                            .font(Constants.Fonts.features)
                            .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
                        Spacer()
                        Text(viewModel.character.gender ?? StringConstants.noInfo)
                            .font(Constants.Fonts.features)
                            .foregroundColor(Color(uiColor: Constants.Color.white))
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, minHeight: 124.0)
                .background(Color(uiColor: Constants.Color.blackCard))
                .cornerRadius(Constants.CornerRadius.profileAnyCard)
            }
    }

    // MARK: - OriginStackSection -
    var originStackSection: some View {
        Section(header: Text(.origin)
            .font(Constants.Fonts.titleSecondary)
            .foregroundColor(Color(uiColor: Constants.Color.white))
            .padding(8)) {

                HStack {
                    Image(.planet)
                        .frame(width: Constants.Constraints.planetImageViewSize,
                               height: Constants.Constraints.planetImageViewSize)
                        .background(Color(uiColor: Constants.Color.blackElements))
                        .cornerRadius(Constants.CornerRadius.profileImage)

                    VStack(alignment: .leading) {
                        Text(viewModel.location?.name ?? StringConstants.noInfo)
                            .font(Constants.Fonts.titleSecondary)
                            .foregroundColor(Color(uiColor: Constants.Color.white))
                            .padding(4)

                        Text(viewModel.location?.type ?? StringConstants.noInfo)
                            .font(Constants.Fonts.descriptionLeft)
                            .foregroundColor(Color(uiColor: Constants.Color.primary))
                            .padding(4)
                    }
                    Spacer()
                }
                .padding(8)
                .frame(maxWidth: .infinity, minHeight: 80.0)
                .background(Color(uiColor: Constants.Color.blackCard))
                .cornerRadius(Constants.CornerRadius.profileAnyCard)
            }
    }

    // MARK: - EpisodesStackSection -
    var episodesStackSection: some View {
        Section(header: Text("Episodes")
            .font(Constants.Fonts.titleSecondary)
            .foregroundColor(Color(uiColor: Constants.Color.white))
            .padding(8)) {
                ForEach(viewModel.episodes, id: \.self) { episode in
                    EpisodeSection(episodeModel: episode)
                }
            }
    }
}
