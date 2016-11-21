//
//  QuizViewController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/13/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

func quizViewController(question: QuizQuestion) -> ViewController<QuizQuestion> {
    return ViewController { callback in
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        let _ = viewController.view // Force loading of the view
        viewController.quizTextView.text = question.question
        viewController.onComplete = callback
        
        return viewController
    }
}

final class QuizViewController: UIViewController {
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    var onComplete: ((QuizQuestion) -> ())?

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        (quizTextView.text, answerTextField.text) <*> onComplete
    }
}
