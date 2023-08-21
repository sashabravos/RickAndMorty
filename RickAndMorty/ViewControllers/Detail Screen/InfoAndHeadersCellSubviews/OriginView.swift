//
//  OriginStackView.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class OriginView: UIView {
    
    // MARK: - Planet Features
    lazy var planetName = WhiteSemiBoldLabel(name: "Earth")
    lazy var bottomTitle = SmallGreenLabel(name: "Planet")
    lazy var planetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.CornerRadius.planetImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "rick")
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
        [planetImageView, planetName, bottomTitle].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
//        self.addSomeSubviews([planetImageView, planetName, bottomTitle])
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.Constraints.originCardHeight),
            
            planetImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.planetImageSize),
            planetImageView.heightAnchor.constraint(equalTo: planetImageView.widthAnchor),
            planetImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: Constants.Constraints.planetImageBorderGap),
            planetImageView.topAnchor.constraint(equalTo: self.topAnchor,
                                                 constant: Constants.Constraints.planetImageBorderGap),

            planetName.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: Constants.Constraints.profileVerticalGap),
            planetName.leadingAnchor.constraint(equalTo: planetImageView.trailingAnchor,
                                                constant: Constants.Constraints.profileSideGap),

            bottomTitle.topAnchor.constraint(equalTo: planetName.bottomAnchor,
                                             constant: Constants.Constraints.profileVerticalGap),
            bottomTitle.leadingAnchor.constraint(equalTo: planetName.leadingAnchor)
        ])
    }
}
