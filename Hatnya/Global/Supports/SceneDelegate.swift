//
//  SceneDelegate.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
                window = UIWindow(windowScene: windowScene)
                let mainViewController = CreateStudyViewController()

                window?.rootViewController = mainViewController
                window?.makeKeyAndVisible()
    }

}
