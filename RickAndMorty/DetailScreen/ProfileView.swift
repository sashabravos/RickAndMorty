//
//  ProfileView.swift
//  SwiftUISheets
//
//  Created by Александра Кострова on 02.10.2023.
//

import SwiftUI

struct ProfileView: View {
//    @StateObject var viewModel: ProfileViewModel
    @State var episodes: [Episode] = []

    var characterModel: Character
    var locationModel: Location?

    private let service = NetworkService.shared

    var body: some View {
        ScrollView {
            CharacterImageView(imageURL: URL(string: characterModel.image ?? ""))

            Text(characterModel.name)
                .font(SwiftUIConstants.Fonts.profileName)
                .foregroundColor(Color(uiColor: Constants.Color.white))
                .padding(8)

            Text(characterModel.status ?? "Unknown")
                .font(SwiftUIConstants.Fonts.stateOfLife)
                .foregroundColor(Color(uiColor: Constants.Color.primary))
                .padding(8)

            // MARK: - Info -
            Section(header: Text("Info")
                .font(SwiftUIConstants.Fonts.titleSecondary)
                .foregroundColor(Color(uiColor: Constants.Color.white))
                .padding(8)
                .frame(maxWidth: .infinity)) {

                    VStack {
                        HStack(alignment: .bottom) {
                            Text("Species:")
                                .font(SwiftUIConstants.Fonts.features)
                                .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
                            Spacer()
                            Text(characterModel.species ?? "Unknown")
                                .font(SwiftUIConstants.Fonts.features)
                                .foregroundColor(Color(uiColor: Constants.Color.white))
                        }
                        Spacer()

                        HStack(alignment: .bottom) {
                            Text("Type:")
                                .font(SwiftUIConstants.Fonts.features)
                                .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
                            Spacer()
                            Text(characterModel.type ?? "Unknown")
                                .font(SwiftUIConstants.Fonts.features)
                                .foregroundColor(Color(uiColor: Constants.Color.white))
                        }
                        Spacer()

                        HStack(alignment: .bottom) {
                            Text("Gender:")
                                .font(SwiftUIConstants.Fonts.features)
                                .foregroundColor(Color(uiColor: Constants.Color.grayNormal))
                            Spacer()
                            Text(characterModel.gender ?? "Unknown")
                                .font(SwiftUIConstants.Fonts.features)
                                .foregroundColor(Color(uiColor: Constants.Color.white))
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, minHeight: 124.0)
                    .background(Color(uiColor: Constants.Color.blackCard))
                    .cornerRadius(Constants.CornerRadius.profileAnyCard)
                }
            // MARK: - Origin -
            Section(header: Text("Origin")
                .font(SwiftUIConstants.Fonts.titleSecondary)
                .foregroundColor(Color(uiColor: Constants.Color.white))
                .padding(8)) {

                    HStack {
                        Image("planet")
                            .frame(width: Constants.Constraints.planetImageViewSize,
                                   height: Constants.Constraints.planetImageViewSize)
                            .background(Color(uiColor: Constants.Color.blackElements))
                            .cornerRadius(Constants.CornerRadius.profileImage)

                        VStack(alignment: .leading) {
                            Text(locationModel?.name ?? "Unknown")
                                .font(SwiftUIConstants.Fonts.titleSecondary)
                                .foregroundColor(Color(uiColor: Constants.Color.white))
                                .padding(4)

                            Text(locationModel?.type ?? "Unknown")
                                .font(SwiftUIConstants.Fonts.descriptionLeft)
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
            // MARK: - Episodes -
            Section(header: Text("Episodes")
                .font(SwiftUIConstants.Fonts.titleSecondary)
                .foregroundColor(Color(uiColor: Constants.Color.white))
                .padding(8)) {
                    ForEach(episodes, id: \.self) { episode in
                        EpisodeSection(episodeModel: episode)
                    }
                }
        }
        .padding(8)
        .background(Color(uiColor: Constants.Color.blackBG))
        .onAppear {
            getCharacterEpisodes()
        }
    }
}

extension ProfileView {
    private func getCharacterEpisodes() {
        if let episodesList = characterModel.episode {
            service.getEpisodes(episodesList) { episodes = $0 }
        }
    }
}
