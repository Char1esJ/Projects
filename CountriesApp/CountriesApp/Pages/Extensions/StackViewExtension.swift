//
//  StackViewExtension.swift
//  Assignment-N20
//
//  Created by Charles Janjgava on 10/23/25.
//

import UIKit

extension UIStackView {
    static func make(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = alignment
        return stackView
    }
}
