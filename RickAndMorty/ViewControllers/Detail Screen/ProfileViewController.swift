//
//  ProfileViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedCharacter: Character!
    private lazy var episodes: [String] = []
    private lazy var originURL = ""
    
    // MARK: - UI Elements

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.Color.blackBG
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        prepareProfileInfo(with: selectedCharacter)
    }
    
    // MARK: - UI Setup

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = Constants.Color.white
        navigationController?.navigationBar.barTintColor = Constants.Color.blackBG
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.backgroundColor = Constants.Color.blackBG
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifier)
        tableView.register(InfoAndHeadersCell.self, forCellReuseIdentifier: InfoAndHeadersCell.identifier)
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 1
        case 2: return episodes.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let profileCell = tableView.dequeueReusableCell(
                withIdentifier: ProfileCell.identifier,
                                                            for: indexPath) as! ProfileCell
            profileCell.configure(with: selectedCharacter)
            return profileCell
        case 1:
            let infoCell = tableView.dequeueReusableCell(
                withIdentifier: InfoAndHeadersCell.identifier,
                                                         for: indexPath) as! InfoAndHeadersCell
            loadLocationInfo { locationInfo in
                if let locationInfo = locationInfo {
                    infoCell.configure(with: locationInfo, by: self.selectedCharacter)
                }
            }
            return infoCell
        case 2:
            let episodeCell = tableView.dequeueReusableCell(
                withIdentifier: EpisodeCell.identifier,
                for: indexPath) as! EpisodeCell
            loadEpisodeInfo(indexPath: indexPath) { episodeInfo in
                if let episodeInfo = episodeInfo {
                    episodeCell.configure(with: episodeInfo)
                }
            }
            return episodeCell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Data Loading

extension ProfileViewController {
    
    private func prepareProfileInfo(with profileInfo: Character) {
            if let planetURL = profileInfo.origin?.url {
                originURL = planetURL
            }
            
            if let episodesList = profileInfo.episode {
                episodes = episodesList
            }
            
            tableView.reloadData()
        }
    
    private func loadLocationInfo(completion: @escaping (Location?) -> Void) {
        if let locationNumber = selectedCharacter.origin?.url?.split(separator: "/").last,
           let locationID = Int(locationNumber) {
            Task {
                do {
                    let locationInfo: Location =
                        try await RequestManager.shared.getInfo(dataType: .location, id: locationID)
                    completion(locationInfo)
                } catch {
                    print("Ошибка декодирования данных: \(error)")
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
    
    private func loadEpisodeInfo(indexPath: IndexPath, completion: @escaping (Episode?) -> Void) {
        let episodeURLString = episodes[indexPath.row]
        
        if let episodeNumber = episodeURLString.split(separator: "/").last,
           let episodeID = Int(episodeNumber) {
            Task {
                do {
                    let episodeInfo: Episode =
                        try await RequestManager.shared.getInfo(dataType: .episode, id: episodeID)
                    completion(episodeInfo)
                } catch {
                    print("Ошибка декодирования данных: \(error)")
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}
