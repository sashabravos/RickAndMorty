//
//  Constants.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

enum Constants {
    // Сlick on the square to change its color.
    enum Color {
        static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let primary = #colorLiteral(red: 0.2784313725, green: 0.7764705882, blue: 0.0431372549, alpha: 1)
        static let blackBG = #colorLiteral(red: 0.01568627451, green: 0.04705882353, blue: 0.1176470588, alpha: 1)
        static let blackCard = #colorLiteral(red: 0.1490196078, green: 0.1647058824, blue: 0.2196078431, alpha: 1)
        static let blackElements = #colorLiteral(red: 0.09803921569, green: 0.1098039216, blue: 0.1647058824, alpha: 1)
        static let textSecondary = #colorLiteral(red: 0.5764705882, green: 0.5960784314, blue: 0.6117647059, alpha: 1)
        static let grayNormal = #colorLiteral(red: 0.768627451, green: 0.7882352941, blue: 0.8078431373, alpha: 1)
    }
    
    enum Fonts {
        // Characters
        static let charactersTitle =  UIFont(name: "Gilroy-Bold", size: 28.0)
        static let characterCardName = UIFont(name: "Gilroy-SemiBold", size: 17.0)

        // Profile
        static let profileName = UIFont(name: "Gilroy-Bold", size: 22)
        static let stateOfLife = UIFont(name: "Gilroy-Medium", size: 16.0)
        static let titleSecondary = UIFont(name: "Gilroy-SemiBold", size: 17.0)
        static let features = UIFont(name: "Gilroy-Medium", size: 16.0)
        static let descriptionLeft = UIFont(name: "Gilroy-Medium", size: 13.0)
        static let descriptionRight = UIFont(name: "Gilroy-Medium", size: 12.0)
    }

    enum Constraints {  
        static let cardHeight = 202.0
        static let cardWidth = 156.0
        static let cardImageSquareSize = 140.0
        static let cardTitleHeight = 22.0
        static let planetImageViewSize = 64.0
    }
    
    enum CornerRadius {
        static let cellCard = 16.0
        static let profileImage = 16.0
        static let profileAnyCard = 16.0
        static let planetImage = 10.0
    }
    
    enum Image {
        static let planet = UIImage(named: "planet")
    }
}
