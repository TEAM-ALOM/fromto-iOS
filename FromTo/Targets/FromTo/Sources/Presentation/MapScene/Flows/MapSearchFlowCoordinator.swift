//
//  MapFlowCoordinator.swift
//  FromTo
//
//  Created by 송영모 on 2023/08/04.
//  Copyright © 2023 alom.com. All rights reserved.
//

import UIKit

protocol MapSearchFlowCoordinatorDependencies  {
    func makeMapSearchViewController() -> MapSearchViewController
//    func makeMoviesListViewController(
//        actions: MoviesListViewModelActions
//    ) -> MoviesListViewController
//    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController
//    func makeMoviesQueriesSuggestionsListViewController(
//        didSelect: @escaping MoviesQueryListViewModelDidSelectAction
//    ) -> UIViewController
}

final class MapSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MapSearchFlowCoordinatorDependencies

    private weak var mapSearchViewController: MapSearchViewController?
//    private weak var moviesListVC: MoviesListViewController?
//    private weak var moviesQueriesSuggestionsVC: UIViewController?

    init(navigationController: UINavigationController,
         dependencies: MapSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
//        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails,
//                                                 showMovieQueriesSuggestions: showMovieQueriesSuggestions,
//                                                 closeMovieQueriesSuggestions: closeMovieQueriesSuggestions)
//        let vc = dependencies.makeMoviesListViewController(actions: actions)
        let viewController = dependencies.makeMapSearchViewController()

        navigationController?.pushViewController(viewController, animated: false)
        mapSearchViewController = viewController
    }

//    private func showMovieDetails(movie: Movie) {
//        let vc = dependencies.makeMoviesDetailsViewController(movie: movie)
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    private func showMovieQueriesSuggestions(didSelect: @escaping (MovieQuery) -> Void) {
//        guard let moviesListViewController = moviesListVC, moviesQueriesSuggestionsVC == nil,
//            let container = moviesListViewController.suggestionsListContainer else { return }
//
//        let vc = dependencies.makeMoviesQueriesSuggestionsListViewController(didSelect: didSelect)
//
//        moviesListViewController.add(child: vc, container: container)
//        moviesQueriesSuggestionsVC = vc
//        container.isHidden = false
//    }
//
//    private func closeMovieQueriesSuggestions() {
//        moviesQueriesSuggestionsVC?.remove()
//        moviesQueriesSuggestionsVC = nil
//        moviesListVC?.suggestionsListContainer.isHidden = true
//    }
}
