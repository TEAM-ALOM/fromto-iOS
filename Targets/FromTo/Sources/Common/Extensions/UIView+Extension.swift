//
//  UIView+Extension.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/23.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
