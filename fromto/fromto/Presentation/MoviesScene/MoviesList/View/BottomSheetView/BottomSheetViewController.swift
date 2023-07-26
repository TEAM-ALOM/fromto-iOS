//
//  BottomSheetViewController.swift
//  fromto
//
//  Created by 민지은 on 2023/07/12.
//

import UIKit

@available(iOS 13.4, *)
class BottomSheetViewController: BaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        addSubView()
        autoLayoutView()
        
    }
    
}
