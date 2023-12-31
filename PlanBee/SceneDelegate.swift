//
//  SceneDelegate.swift
//  PlanBee
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let tabBar  = TabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = ThemeColor.PlanBeeBackgroundColor
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        if let rawValue: Int = UserDefaultsManager.shared.getValue(forKey: "Appearance") {
            window?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: rawValue) ?? .unspecified
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        UIApplication.shared.applicationIconBadgeNumber = 0 // 배지 초기화
        UserNotificationManager.shared.removeAllDeliveredAlarm() // 이미 표시된 알림 삭제
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
