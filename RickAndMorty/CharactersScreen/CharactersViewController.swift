//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import Combine
import UIKit

final class CharactersViewController: UIViewController {
    // MARK: - Properties -
    @IBOutlet weak var collectionView: UICollectionView!

    private let viewModel = CharactersViewModel()
    private var receiveQueue: DispatchQueue = .main
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadCharacters()
        setupCollectionView()

        sinkForReloadSubject()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationTitle()
    }

    // MARK: - Private methods -
    private func setupNavigationTitle() {
        let customTitleView = UIView(
            frame: CGRect(
                x: 0, y: 0,
                width: UIScreen.main.bounds.width,
                height: 35
            )
        )

        let titleLabel = UILabel(
            frame: CGRect(
                x: 24, y: 0,
                width: 149, height: 34
            )
        )
        titleLabel.text = .charactersTitle
        titleLabel.textColor = .white
        titleLabel.font = Constants.Fonts.charactersTitle

        customTitleView.addSubview(titleLabel)
        navigationController?.navigationBar.addSubview(customTitleView)
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: .characterCellName, bundle: nil),
            forCellWithReuseIdentifier: .characterCellName
        )
    }
}

// MARK: - UICollectionViewDataSource -
extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .characterCellName, for: indexPath) as! CharacterCell
        cell.configureCell(model: viewModel.characters[indexPath.row])
        return cell
    }

}

// MARK: - UICollectionViewDelegate -
extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters[indexPath.item]
        if let viewController = UIStoryboard(name: "DetailScreen", bundle: nil).instantiateViewController(withIdentifier: "DetailScreen") as? ProfileViewController {
            viewController.viewModel = ProfileViewModel(selectedCharacter)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate -
extension CharactersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.size.height

        if scrollView.contentOffset.y > contentHeight - boundsHeight {
            viewModel.loadCharacters()
        }
    }
}

// MARK: - Sink -
extension CharactersViewController {
    private func sinkForReloadSubject() {
        viewModel.reloadSubject
            .receive(on: receiveQueue)
            .sink { [weak self] in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}
