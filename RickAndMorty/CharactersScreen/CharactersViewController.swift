//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import Combine
import SnapKit
import SwiftUI
import UIKit

final class CharactersViewController: UIViewController {
    // MARK: - Properties -
    private let viewModel: CharactersViewModel
    private var receiveQueue: DispatchQueue
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initialisation -
    init(viewModel: CharactersViewModel,
         receiveQueue: DispatchQueue = .main) {
        self.viewModel = viewModel
        self.receiveQueue = receiveQueue
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCharacterView()
        sinkForProfileSubject()
    }

    // MARK: - Private methods -
    private func setupCharacterView() {
        let view = CharactersView(viewModel: self.viewModel)

        let controller = UIHostingController(rootView: view)
        self.addChild(controller)
        self.view.addSubview(controller.view)

        controller.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Sink -
extension CharactersViewController {
    private func sinkForProfileSubject() {
        viewModel.profileViewSubject
            .receive(on: receiveQueue)
            .sink { [weak self] in
                self?.navigationController?.pushViewController(
                    UIHostingController(rootView: $0),
                    animated: true
                )
            }
            .store(in: &cancellables)
    }
}
