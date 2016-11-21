//
//  StartViewController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/21/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

func startViewController(startButtonName: String) -> ViewController<StartViewController> {
    return ViewController { callback in
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        let _ = viewController.view // Force loading of the view
        viewController.startButton.titleLabel?.text = startButtonName
        viewController.onComplete = callback
        
        return viewController
    }
}

final class StartViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    var onComplete: ((StartViewController) -> ())?
    
    @IBAction func startButtonWasPressed(_ sender: UIButton) {
        self <*> onComplete
    }
    
}
