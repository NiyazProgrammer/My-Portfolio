//
//  SceneDelegate.swift
//  AnimationWeatherApp
//
//  Created by Нияз Ризванов on 18.07.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewModel = MainViewModel()
        let navVC = UINavigationController(rootViewController: MainViewController(viewModel: viewModel))
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

