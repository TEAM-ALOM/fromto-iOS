import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
//        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
//        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
//        flow.start()
        
        let mapSceneDIContainer = appDIContainer.makeMapSceneDIContainer()
        let flow = mapSceneDIContainer.makeMapSearchFlowCoordinator(navigationController: navigationController)
        
        flow.start()
    }
}
