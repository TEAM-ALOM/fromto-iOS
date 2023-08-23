//
//  BaseViewController.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/23.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController {
    
    // MARK: - View Lifecylce
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProperty()
        setupDelegate()
        setupHierarchy()
        setupLayout()
        setupBind()
    }
    
    // MARK: - Setup Methods
    
    public func setupProperty() { }
    public func setupDelegate() { }
    public func setupHierarchy() { }
    public func setupLayout() { }
    public func setupBind() { }
}
