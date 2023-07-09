//
//  HomeViewController.swift
//  fromto
//
//  Created by 조성민 on 2023/07/07.
//

import Foundation
import UIKit
import NMapsMap

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
    
}
