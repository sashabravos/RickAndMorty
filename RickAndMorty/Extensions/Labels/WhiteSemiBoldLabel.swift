//
//  WhiteSemiBoldLabel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

final class WhiteSemiBoldLabel: UILabel {
        
    init(name: String? = nil) {
        super.init(frame: .zero)
        self.font = Constants.Font.titleSecondary
        self.textColor = Constants.Color.white
        self.text = name
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
