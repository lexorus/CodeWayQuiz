//
//  Quiz.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/21/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

typealias QuizQuestion = (question: String, answer: String?)

final class Quiz {
    
    private var questions: [QuizQuestion] = [
        ("What is your full name?", nil),
        ("How was the conference?", nil),
        ("How was the speakers?", nil),
        ("How does it work???\n🤔", nil)
    ]
    
    func turn(answeredQuestion: QuizQuestion) -> ViewController<QuizQuestion> {
        let indexOfObject = questions.find { $0.question == answeredQuestion.question }
        if let index = indexOfObject {
            questions[index] = answeredQuestion
        }
        let unansweredQuestionFilter: (QuizQuestion) -> Bool = { $0.answer == nil }
        if let unansweredQuestion = questions.filter(unansweredQuestionFilter).first {
            return quizViewController(question: unansweredQuestion)
        } else {
            return quizViewController(question: ("Thank you for your answers", nil))
        }
    }
    
    func flow() -> NavigationController<QuizQuestion> {
        var navigation = navigationController(quizViewController(question: questions.first!))
        questions.forEach { _ in navigation = navigation.flatMap(turn) }
        
        return navigation
    }
    
}
