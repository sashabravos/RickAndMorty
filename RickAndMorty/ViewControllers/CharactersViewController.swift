//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    
    var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            label.adjustsFontSizeToFitWidth = true
        label.text = "Characters"
//            label.minimumScaleFactor = FontSizes.scaleFactor
            label.numberOfLines = 1
            label.textAlignment = .left
        label.contentMode = .bottomLeft
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return label
        }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8 // Расстояние между ячейками в ряду
        layout.minimumLineSpacing = 16 // Вертикальное расстояние между строками

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CharacterCard.self,
                                forCellWithReuseIdentifier: CharacterCard.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.Color.blackBG
        navigationController?.navigationBar.prefersLargeTitles = true
                
        setViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cellWidth = 156
        cellHeight = 202
    }
    
    private func setViews() {
        collectionView.backgroundColor = .clear

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 41.0),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20.0),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 134.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CharactersViewController: UICollectionViewDelegate {
    
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

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
