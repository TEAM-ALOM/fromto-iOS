import UIKit

@available(iOS 13.4, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let TabBarViewController = TabBarViewController()
        window?.rootViewController = TabBarViewController

        window?.makeKeyAndVisible()
    
        return true
    }

}

