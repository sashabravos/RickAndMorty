//
//  ProfileViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 25.11.2023.
//

import Combine
import SnapKit
import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Properties -
    @IBOutlet weak var tableView: UITableView?

    var viewModel: ProfileViewModel? = nil
    private var receiveQueue: DispatchQueue = .main
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
        setupTableView()

        sinkForReloadSubject()
    }

    private func setupTableView() {
        guard let tableView else {
            return
        }
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: .profileCellName, bundle: nil),
            forCellReuseIdentifier: .profileCellName
        )
        tableView.register(
            UINib(nibName: .infoCellName, bundle: nil),
            forCellReuseIdentifier: .infoCellName
        )
        tableView.register(
            UINib(nibName: .originCellName, bundle: nil),
            forCellReuseIdentifier: .originCellName
        )
        tableView.register(
            UINib(nibName: .episodesCellName, bundle: nil),
            forCellReuseIdentifier: .episodesCellName
        )
    }

    private func setupCustomBackButton() {
        self.navigationItem.hidesBackButton = true

        if !navigationController!.navigationBar.subviews.isEmpty {
            navigationController?.navigationBar.subviews.forEach {
                $0.snp.removeConstraints()
                $0.removeFromSuperview()
            }
        }

        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 24, y: 0, width: 24, height: 24)
        backButton.setImage(#imageLiteral(resourceName: "chevron-left.png"), for: .normal)
        backButton.addTarget(self, action: #selector(popCurrentController), for: .touchUpInside)

        let customBackButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackButton
    }

    @objc private func popCurrentController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource -
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return viewModel?.episodes.count ?? 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let profileCell = tableView.dequeueReusableCell(withIdentifier: .profileCellName,
                                                            for: indexPath) as! ProfileCell
            profileCell.configureCell(model: viewModel?.character)
            return profileCell
        case 1:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: .infoCellName,
                                                            for: indexPath) as! InfoCell
            infoCell.configureCell(character: viewModel?.character)
            return infoCell
        case 2:
            let originCell = tableView.dequeueReusableCell(withIdentifier: .originCellName,
                                                            for: indexPath) as! OriginCell
            originCell.configureCell(location: viewModel?.location)
            return originCell
        case 3:
            let episodesCell = tableView.dequeueReusableCell(withIdentifier: .episodesCellName,
                                                            for: indexPath) as! EpisodesCell
            viewModel?.episodes.forEach {
                episodesCell.configureCell(model: $0)
            }
            return episodesCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Sink -
extension ProfileViewController {
    private func sinkForReloadSubject() {
        viewModel?.reloadSubject
            .receive(on: receiveQueue)
            .sink { [weak self] in
                self?.tableView?.reloadData()
            }
            .store(in: &cancellables)
    }
}
