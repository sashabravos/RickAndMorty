//
//  ProfileViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 25.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
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
