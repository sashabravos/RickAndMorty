//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = Constants.Font.charactersTitle
        label.numberOfLines = 1
        label.textAlignment = .left
        label.contentMode = .bottomLeft
        label.textColor = Constants.Color.white
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: Constants.Constraints.cardWidth,
                                height: Constants.Constraints.cardHeight)
        layout.sectionInset = .init(top: 0,
                                    left: 0,
                                    bottom: 0,
                                    right: Constants.Constraints.charactersHalfHorizontalGap)
        layout.minimumInteritemSpacing = Constants.Constraints.charactersHalfHorizontalGap
        layout.minimumLineSpacing = Constants.Constraints.charactersHorizontalGap
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CharacterCard.self,
                                forCellWithReuseIdentifier: CharacterCard.identifier)
        return collectionView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = Constants.Constraints.charactersVerticalGap
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(collectionView)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superviewSettings()
        setupSubviews()
        
    }
    
    private func superviewSettings() {
        view.backgroundColor = Constants.Color.blackBG
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupSubviews() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: Constants.Constraints.charactersVerticalGap),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.Constraints.charactersSideGap),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -Constants.Constraints.charactersSideGap),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.charactersTitleHeight),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Constants.Constraints.charactersVerticalGap)
        ])
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("You selected cell #\(indexPath.item)!")
        }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCard.identifier,
                                                         for: indexPath) as? CharacterCard {
            let image = UIImage(named: "rick")
            let title = "Rick Sanchez"
            
            cell.configure(with: image ?? UIImage(), title: title)
            
            return cell
        }
        return UICollectionViewCell()
    }
}
