import UIKit
import UI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp()
        return true
    }
    
    func configureApp() {
        let pokemonVC = makePokemonListViewController()
        let navigationVC = UINavigationController(rootViewController: pokemonVC)
        navigationVC.isNavigationBarHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationVC
        self.window = window
        
        window.makeKeyAndVisible()
    }

}

