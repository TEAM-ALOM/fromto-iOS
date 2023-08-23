//
//  MapSceneDIContainer.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/04.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit
import SwiftUI

final class MapSceneDIContainer: MapSearchFlowCoordinatorDependencies {
    struct Dependencies { }
    
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    
    // MARK: - Repositories
    
    // MARK: - Map Search
    
    func makeMapSearchViewController() -> MapSearchViewController {
        return MapSearchViewController(
            viewModel: self.makeMapSearchViewModel()
        )
    }
    
    func makeMapSearchViewModel() -> MapSearchViewModel {
        return MapSearchViewModel()
    }

    // MARK: - Flow Coordinators
    
    func makeMapSearchFlowCoordinator(navigationController: UINavigationController) -> MapSearchFlowCoordinator {
        return MapSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

