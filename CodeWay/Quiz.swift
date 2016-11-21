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
        ("question1", nil),
        ("question2", nil),
        ("question3", nil),
        ("question4", nil)
    ]
    
    func turn(unsweredQuestion: QuizQuestion) -> ViewController<QuizQuestion> {
        let indexOfObject = questions.find { $0.question == unsweredQuestion.question }
        if let index = indexOfObject {
            questions[index] = unsweredQuestion
        }
        let unansweredQuestionFilter: (QuizQuestion) -> Bool = { $0.answer == nil }
        if let unansweredQuestion = questions.filter(unansweredQuestionFilter).first {
            return quizViewController(question: unansweredQuestion)
        } else {
            print(questions)
            return quizViewController(question: ("Thank you for your answers", nil))
        }
    }
    
    func flow() -> NavigationController<QuizQuestion> {
        var navigation = navigationController(quizViewController(question: questions.first!))
        questions.forEach { _ in navigation = navigation.flatMap(turn) }
        
        return navigation
    }
    
}
