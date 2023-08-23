//
//  OriginStackView.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class OriginView: UIView {
    
    // MARK: - Planet Features
    lazy var planetName = WhiteSemiBoldLabel(name: "Unknown")
    lazy var planetType = SmallGreenLabel(name: "Unknown")
    private lazy var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.CornerRadius.planetImage
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Constants.Color.blackElements
        imageView.image = Constants.Image.planet
        return imageView
    }()
  
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.layer.cornerRadius = Constants.CornerRadius.profileAnyCard
        self.backgroundColor = Constants.Color.blackCard
        self.translatesAutoresizingMaskIntoConstraints = false
        [planetImageView, planetName, planetType].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.Constraints.originCardHeight),
            
            planetImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.planetImageViewSize),
            planetImageView.heightAnchor.constraint(equalTo: planetImageView.widthAnchor),
            planetImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: Constants.Constraints.planetImageBorderGap),
            planetImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                 constant: Constants.Constraints.planetImageBorderGap),
            
            planetName.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: Constants.Constraints.profileVerticalGap),
            planetName.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor,
                                                constant: Constants.Constraints.profileSideGap),
            
            planetType.topAnchor.constraint(equalTo: planetName.bottomAnchor,
                                            constant: Constants.Constraints.profileVerticalGap),
            planetType.leadingAnchor.constraint(equalTo: planetName.leadingAnchor)
        ])
    }
}
