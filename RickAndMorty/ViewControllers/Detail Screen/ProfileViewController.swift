//
//  ProfileViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = Constants.Color.blackBG
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
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

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var sectionCount = 0
        
        if section == 0 || section == 1 {
            sectionCount = 1
        } else if section == 2 {
            sectionCount = 10
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier,
                                                            for: indexPath) as! ProfileCell
            return profileCell
        } else if indexPath.section == 1 {
            let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoAndHeadersCell.identifier,
                                                         for: indexPath) as! InfoAndHeadersCell
            return infoCell
            
        } else if indexPath.section == 2 {
            let episodeCell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier,
                                                            for: indexPath) as! EpisodeCell
            return episodeCell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

}

extension ProfileViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        if let lastIndexPath = indexPaths.last,
//           lastIndexPath.row == posts.count - 1 {
//            Task {
//                await loadData()
//            }
//        }
    }
}
