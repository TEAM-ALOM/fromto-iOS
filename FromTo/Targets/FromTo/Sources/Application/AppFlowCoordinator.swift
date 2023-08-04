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
        let mapSceneDIContainer = appDIContainer.makeMapSceneDIContainer()
        let flow = mapSceneDIContainer.makeMapSearchFlowCoordinator(navigationController: navigationController)
        
        flow.start()
    }
}
