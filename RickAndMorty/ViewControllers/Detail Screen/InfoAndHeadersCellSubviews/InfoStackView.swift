//
//  InfoStackView.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//
import UIKit

final class InfoStackView: UIStackView {

    // MARK: - Left Labels
    
    private lazy var speciesLeft = makeLabel(with: "Species")
    private lazy var typeLeft = makeLabel(with: "Type")
    private lazy var genderLeft = makeLabel(with: "Gender")
    
    // MARK: - Right Labels
    
    lazy var speciesRight = makeLabel(with: "Unknown")
    lazy var typeRight = makeLabel(with: "Unknown")
    lazy var genderRight = makeLabel(with: "Unknown")
    
    // MARK: - Containers
    
    private lazy var speciesContainer = makeLabelContainer(speciesLeft, speciesRight)
    private lazy var typeContainer = makeLabelContainer(typeLeft, typeRight)
    private lazy var genderContainer = makeLabelContainer(genderLeft, genderRight)
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        
        setupStackView()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.font = Constants.Font.features
        label.textColor = Constants.Color.grayNormal
        label.textAlignment = .left
        label.text = text
        return label
    }
    
    private func makeLabelContainer(_ leftLabel: UILabel, _ rightLabel: UILabel) -> UIStackView {
        let labelContainer = UIStackView()
        labelContainer.axis = .horizontal
        labelContainer.alignment = .fill
        labelContainer.distribution = .fillEqually
        labelContainer.addArrangedSubview(leftLabel)
        labelContainer.addArrangedSubview(rightLabel)
        return labelContainer
    }
    
    private func setupStackView() {
        self.distribution = .fillEqually
        self.axis = .vertical
        self.alignment = .center
        self.layer.cornerRadius = Constants.CornerRadius.profileAnyCard
        self.backgroundColor = Constants.Color.blackCard
        self.addArrangedSubviews([speciesContainer, typeContainer, genderContainer])
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.Constraints.infoCardHeight),
            speciesContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                     constant: Constants.Constraints.profileSideGap),
            speciesContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                      constant: -Constants.Constraints.profileSideGap),
            typeContainer.leadingAnchor.constraint(equalTo: speciesContainer.leadingAnchor),
            typeContainer.trailingAnchor.constraint(equalTo: speciesContainer.trailingAnchor),
            genderContainer.leadingAnchor.constraint(equalTo: speciesContainer.leadingAnchor),
            genderContainer.trailingAnchor.constraint(equalTo: speciesContainer.trailingAnchor)
        ])
    }
}
