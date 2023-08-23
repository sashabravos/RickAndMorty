//
//  InfoStackView.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class InfoStackView: UIStackView {

    // MARK: - Left labels
    private lazy var speciesLeft = makeLeftLabel(with: "Species")
    private lazy var typeLeft = makeLeftLabel(with: "Type")
    private lazy var genderLeft = makeLeftLabel(with: "Gender")
    
    // MARK: - Right labels
    lazy var speciesRight = makeRightLabel(with: "Unknown")
    lazy var typeRight = makeRightLabel(with: "Unknown")
    lazy var genderRight = makeRightLabel(with: "Unknown")
    
    // MARK: - Containers
    private lazy var speciesContainer = makeLabelContainer(speciesLeft,
                                                   speciesRight)
    private lazy var typeContainer = makeLabelContainer(typeLeft,
                                                typeRight)
    private lazy var genderContainer = makeLabelContainer(genderLeft,
                                                  genderRight)
    
    init() {
        super.init(frame: .zero)
        self.distribution = .fillEqually
        self.axis = .vertical
        self.alignment = .center
        self.layer.cornerRadius = Constants.CornerRadius.profileAnyCard
        self.backgroundColor = Constants.Color.blackCard
        self.addSomeSubviews([speciesContainer,
                              typeContainer,
                              genderContainer])
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLeftLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = Constants.Font.features
        label.textColor = Constants.Color.grayNormal
        label.textAlignment = .left
        label.text = text
        return label
    }
    
    private func makeRightLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = Constants.Font.features
        label.textColor = Constants.Color.white
        label.textAlignment = .right
        label.text = text
        return label
    }
    
    private func makeLabelContainer(_ leftLabel: UILabel,
                                    _ rightLabel: UILabel) -> UIStackView {
        let labelContainer = UIStackView()
        labelContainer.axis = .horizontal
        labelContainer.alignment = .fill
        labelContainer.distribution = .fillEqually
        labelContainer.addSomeSubviews([leftLabel, rightLabel])
        return labelContainer
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.Constraints.infoCardHeight),
            
            speciesContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                               constant:
                                                Constants.Constraints.profileSideGap),
            speciesContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -Constants.Constraints.profileSideGap),
            typeContainer.leadingAnchor.constraint(equalTo: speciesContainer.leadingAnchor),
            typeContainer.trailingAnchor.constraint(equalTo: speciesContainer.trailingAnchor),
            genderContainer.leadingAnchor.constraint(equalTo: speciesContainer.leadingAnchor),
            genderContainer.trailingAnchor.constraint(equalTo: speciesContainer.trailingAnchor)
        ])
    }
}
