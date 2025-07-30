//
//  SceneDelegate.swift
//  BBVAiOSTest
//
//  Created by david.santiago on 29/07/25.
//
import UIKit
import Feature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let rootVC = RootViewController()
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
