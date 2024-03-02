//
//  AppDelegate.swift
//  Loodos
//
//  Created by Mustafa Pekdemir on 1.03.2024.
//

import UIKit
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if ReachabilityManager.isConnectedToNetwork() {
            let launchScreenViewController = LaunchScreenViewController()
            presentViewController(launchScreenViewController, atLaunch: true)
        } else {
            let alertController = AlertManager.createAlertController(
                title: "No Internet connection found!",
                message: "Please check your internet connection and try again.",
                buttonTitle: nil
            )
            presentViewController(alertController)
        }
        
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        RemoteConfigManager.configure()
        
        return true
    }
}

// MARK: - Helper Methods
private extension AppDelegate {
    
    func setRootViewController(_ viewController: UIViewController) {
        guard let window = self.window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func presentViewController(
        _ controller: UIViewController,
        atLaunch: Bool = false
    ) {
        guard let window = self.window else { return }
        
        let transitionVC = TransitionScreenViewController()
        setRootViewController(transitionVC)
        
        guard atLaunch else {
            window.rootViewController?.present(controller, animated: true)
            return
        }
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .flipHorizontal
        
        window.rootViewController?.present(controller, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                window.rootViewController?.dismiss(animated: true) { [self] in
                    let navigationController = UINavigationController(
                        rootViewController: MovieListViewController()
                    )
                    setRootViewController(navigationController)
                }
            }
        }
    }
}
