//
//  ProfileImageView.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 08.10.2023.
//

import SwiftUI

struct ProfileImageView: View {
    var imageURL: URL?
    var body: some View {
        AsyncImage(url: imageURL)
        { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.Constraints.cardImageSquareSize,
                           height: Constants.Constraints.cardImageSquareSize)
                    .cornerRadius(Constants.CornerRadius.profileImage)
                    .padding(8)
            case .failure(_), .empty:
                ProgressView()
            @unknown default:
                fatalError()
            }
        }
    }
}
