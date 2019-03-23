//
//  AppDelegate.swift
//  HealthApp
//
//  Created by MisnikovRoman on 23/03/2019.
//  Copyright © 2019 MisnikovRoman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let testVC = storyboard.instantiateViewController(withIdentifier: VC.tabBar)

		window = UIWindow.init(frame: UIScreen.main.bounds)
		window?.rootViewController = testVC
		window?.makeKeyAndVisible()

		return true
	}
}

