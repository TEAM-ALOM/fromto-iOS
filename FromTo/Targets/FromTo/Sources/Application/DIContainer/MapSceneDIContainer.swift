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
    
    
    // MARK: - Map Search
    func makeMapSearchViewController() -> MapSearchViewController {
        return MapSearchViewController(
            viewModel: self.makeMapSearchViewModel()
        )
    }
    
    func makeMapSearchViewModel() -> MapSearchViewModel {
        return MapSearchViewModel()
    }
    
    
    // MARK: - Use Cases
//    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
//        DefaultSearchMoviesUseCase(
//            moviesRepository: makeMoviesRepository(),
//            moviesQueriesRepository: makeMoviesQueriesRepository()
//        )
//    }
    
//    func makeFetchRecentMovieQueriesUseCase(
//        requestValue: FetchRecentMovieQueriesUseCase.RequestValue,
//        completion: @escaping (FetchRecentMovieQueriesUseCase.ResultValue) -> Void
//    ) -> UseCase {
//        FetchRecentMovieQueriesUseCase(
//            requestValue: requestValue,
//            completion: completion,
//            moviesQueriesRepository: makeMoviesQueriesRepository()
//        )
//    }
    
    // MARK: - Repositories
//    func makeMoviesRepository() -> MoviesRepository {
//        DefaultMoviesRepository(
//            dataTransferService: dependencies.apiDataTransferService,
//            cache: moviesResponseCache
//        )
//    }
//    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
//        DefaultMoviesQueriesRepository(
//            moviesQueriesPersistentStorage: moviesQueriesStorage
//        )
//    }
//    func makePosterImagesRepository() -> PosterImagesRepository {
//        DefaultPosterImagesRepository(
//            dataTransferService: dependencies.imageDataTransferService
//        )
//    }
    
    // MARK: - Movies List
//    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController {
//        MoviesListViewController.create(
//            with: makeMoviesListViewModel(actions: actions),
//            posterImagesRepository: makePosterImagesRepository()
//        )
//    }
//
//    func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
//        DefaultMoviesListViewModel(
//            searchMoviesUseCase: makeSearchMoviesUseCase(),
//            actions: actions
//        )
//    }
//
//    // MARK: - Movie Details
//    func makeMoviesDetailsViewController(movie: Movie) -> UIViewController {
//        MovieDetailsViewController.create(
//            with: makeMoviesDetailsViewModel(movie: movie)
//        )
//    }
//
//    func makeMoviesDetailsViewModel(movie: Movie) -> MovieDetailsViewModel {
//        DefaultMovieDetailsViewModel(
//            movie: movie,
//            posterImagesRepository: makePosterImagesRepository()
//        )
//    }
    
    // MARK: - Movies Queries Suggestions List
//    func makeMoviesQueriesSuggestionsListViewController(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> UIViewController {
//        if #available(iOS 13.0, *) { // SwiftUI
//            let view = MoviesQueryListView(
//                viewModelWrapper: makeMoviesQueryListViewModelWrapper(didSelect: didSelect)
//            )
//            return UIHostingController(rootView: view)
//        } else { // UIKit
//            return MoviesQueriesTableViewController.create(
//                with: makeMoviesQueryListViewModel(didSelect: didSelect)
//            )
//        }
//    }
    
//    func makeMoviesQueryListViewModel(didSelect: @escaping MoviesQueryListViewModelDidSelectAction) -> MoviesQueryListViewModel {
//        DefaultMoviesQueryListViewModel(
//            numberOfQueriesToShow: 10,
//            fetchRecentMovieQueriesUseCaseFactory: makeFetchRecentMovieQueriesUseCase,
//            didSelect: didSelect
//        )
//    }

//    @available(iOS 13.0, *)
//    func makeMoviesQueryListViewModelWrapper(
//        didSelect: @escaping MoviesQueryListViewModelDidSelectAction
//    ) -> MoviesQueryListViewModelWrapper {
//        MoviesQueryListViewModelWrapper(
//            viewModel: makeMoviesQueryListViewModel(didSelect: didSelect)
//        )
//    }

    // MARK: - Flow Coordinators
    func makeMapSearchFlowCoordinator(navigationController: UINavigationController) -> MapSearchFlowCoordinator {
        return MapSearchFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
//    func makeMoviesSearchFlowCoordinator(navigationController: UINavigationController) -> MoviesSearchFlowCoordinator {
//        MoviesSearchFlowCoordinator(
//            navigationController: navigationController,
//            dependencies: self
//        )
//    }
}

