//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    private lazy var characters: [Character] = []
    private lazy var currentPage = 1
    private lazy var isLoadingData = false
    
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
        stackView.addSomeSubviews([titleLabel, collectionView])
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        superviewSettings()
        setupSubviews()
        Task {
            await loadData()
        }
    }
    
    private func loadData() async {
        guard !isLoadingData else { return }
        
        isLoadingData = true
        
        do {
            let characterModel: CharactersModel =
            try await RequestManager.shared.getInfo(dataType: .character,
                                                    page: currentPage)
            
            appendCharacters(characterModel.results, characterModel.info)
            
        } catch {
            handleError(error)
        }
    }
    
    private func appendCharacters(_ charactersInfo: [Character],
                                  _ pageInfo: Info) {
        characters.append(contentsOf: charactersInfo)
        collectionView.reloadData()
        
        if pageInfo.next != nil {
            currentPage += 1
            isLoadingData = false
        }
    }
    
    private func handleError(_ error: Error) {
        print("Ошибка декодирования данных: \(error)")
        isLoadingData = false
    }
    
    private func superviewSettings() {
        view.backgroundColor = Constants.Color.blackBG
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
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
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCard.identifier,
                                                         for: indexPath) as? CharacterCard {
            let person = characters[indexPath.row]
            cell.configure(with: person)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension CharactersViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if let lastIndexPath = indexPaths.last,
            lastIndexPath.row >= characters.count - 1 {
            Task {
                await loadData()
            }
        }
    }
}
