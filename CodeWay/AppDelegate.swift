//
//  AppDelegate.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/13/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = quizApp()
        
        return true
    }
    
    private func quizApp() -> UIViewController {
        let quizFlow = Quiz().flow()
        
        let startInterface = startViewController(startButtonName: "Start Quiz")
        return startInterface.run { controller in
            controller.presentModal(flow: quizFlow) { _ in }
        }
    }
    
}

