//
//  QuizViewController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/13/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

final class QuizViewController: UIViewController {
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerTextField: UITextField!

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        print("nextButtonPressed")
    }
    
}
