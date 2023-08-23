//
//  StackView+Extension.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

extension UIStackView {
    /// Add array of views
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addArrangedSubview(view)
            self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
