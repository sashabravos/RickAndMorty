//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import Combine
import SwiftUI
import UIKit

final class CharactersViewController: UIViewController {
    // MARK: - Published properties -
    @Published var currentCharacter: Character?
    @Published var episodes: [Episode] = []

    // MARK: - Properties
    private var episodesList: [String] = []
    private lazy var originURL = ""

    private lazy var characters: [Character] = []
    private lazy var currentPage = 1
    private lazy var isLoadingData = false

    private var cancellables = Set<AnyCancellable>()

    private let service = NetworkService.shared

    // MARK: - UI Elements

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
        stackView.addArrangedSubviews([titleLabel, collectionView])
        return stackView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        superviewSettings()
        setupSubviews()
        Task {
            await loadData()
        }
        //        selectCharacterPublisher()
        episodes.removeAll()
    }

    // MARK: - UI Setup

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

// MARK: - UICollectionViewDelegate

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentCharacter = characters[indexPath.item]

        if let currentCharacter {
            let detailScreen = ProfileView(characterModel: currentCharacter,
                                                locationModel: currentCharacter.location)
            let hostingController = UIHostingController(rootView: detailScreen)
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource

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

// MARK: - UICollectionViewDataSourcePrefetching

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

// MARK: - Data Loading

extension CharactersViewController {

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
}

// MARK: - Sink -
extension CharactersViewController {
    private func selectCharacterPublisher() {
        $currentCharacter
            .sink { characterInfo in
                if let characterInfo {
                    print("Новый текущий персонаж: \(characterInfo)")
                }
            }
            .store(in: &cancellables)
    }
}
