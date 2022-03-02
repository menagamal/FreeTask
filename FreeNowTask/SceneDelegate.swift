//
//  SceneDelegate.swift
//  FreeNowTask
//
//  Created by Mena Gamal on 01/03/2022.
//

import UIKit
import GoogleMaps
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        GMSServices.provideAPIKey("AIzaSyDWadfW20c7LabIqRQKpoSyz7Db0RIG2O8")
        let window = UIWindow(windowScene: scene)
        self.window = window
        let navigationController = UINavigationController()
        let viewController = ListDataBuilder().instantiate()
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

