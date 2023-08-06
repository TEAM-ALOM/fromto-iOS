//
//  MapViewController.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/04.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit

final class MapSearchViewController: UIViewController {
    typealias ViewModel = MapSearchViewModel
    
    let viewModel: ViewModel
    
    let titleLabel: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
}
