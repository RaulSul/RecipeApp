import UIKit
//import CoreData

@UIApplicationMain class App: UINavigationController, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allRecipesVC = AllRecipesVC()
        pushViewController(allRecipesVC, animated: false)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.overrideUserInterfaceStyle = .light
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()
        window!.rootViewController = self
        
        return true
    }
}


