//
//  ProfileViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var selectedCharacter: Character!

    private var profileModel: ProfileModel!
    private lazy var episodes: [String] = []
    private lazy var originURL = ""
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.Color.blackBG
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        prepareProfileInfo(with: selectedCharacter)
    }
    
    private func prepareProfileInfo(with profileInfo: Character) {
        if let planetURL = profileInfo.origin?.url {
            originURL = planetURL
        }
        
        if let episodesList = profileInfo.episode {
            episodes = episodesList
        }
        
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        
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

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var sectionCount = 0
        
        if section == 0 || section == 1 {
            sectionCount = 1
        } else if section == 2 {
            sectionCount = episodes.count
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier,
                                                            for: indexPath) as! ProfileCell
            if let character = selectedCharacter {
                profileCell.configure(with: character)
            }
            return profileCell
        case 1:
            let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoAndHeadersCell.identifier,
                                                         for: indexPath) as! InfoAndHeadersCell
            if let locationNumber = originURL.split(separator: "/").last,
               let locationID = Int(locationNumber) {
                Task {
                    do {
                let locationInfo: Location
                        = try await RequestManager.shared.getInfo(dataType: .location, id: locationID)
                        infoCell.configure(with: locationInfo, by: selectedCharacter)
                    } catch {
                        print("Ошибка декодирования данных: \(error)")
                    }
                }
            }
            return infoCell
        case 2:
            let episodeCell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier,
                                                            for: indexPath) as! EpisodeCell
            let episodeURLString = episodes[indexPath.row]
            
            if let episodeNumber = episodeURLString.split(separator: "/").last,
               let episodeID = Int(episodeNumber) {
                Task {
                    do {
                        let episodeInfo: Episode =
                        try await RequestManager.shared.getInfo(dataType: .episode, id: episodeID)
                        episodeCell.configure(with: episodeInfo)
                    } catch {
                        print("Ошибка декодирования данных: \(error)")
                    }
                }
            }
            return episodeCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
