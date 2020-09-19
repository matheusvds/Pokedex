import UIKit
import UI
import Infra
import Application

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var main: SceneFactory = {
        let requester = RequestObjectClient(client: URLSessionAdapter())
        let main = Main(requestObject: requester)
        return main
    }()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp()
        return true
    }
    
    func configureApp() {
        let pokemonVC = main.makePokemonListViewController()
        let navigationVC = UINavigationController(rootViewController: pokemonVC)
        navigationVC.isNavigationBarHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationVC
        self.window = window
        
        window.makeKeyAndVisible()
    }

}

