//
//  UIStackView+Extension.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/23.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
