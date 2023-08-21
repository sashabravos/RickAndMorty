//
//  SmallGreenLabel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class SmallGreenLabel: UILabel {
        
    init(name: String) {
        super.init(frame: .zero)
        self.font = Constants.Font.descriptionLeft
        self.textColor = Constants.Color.primary
        self.text = name
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}