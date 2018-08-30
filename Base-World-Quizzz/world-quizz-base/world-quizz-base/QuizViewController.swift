//
//  QuizViewController.swift
//  world-quizz-base
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    
    var fullQuizz: Quizz?
    var question: Question?
    var score: Int = 0
    
    @IBOutlet var answersButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupQuestion(question)
    }
    
    @IBAction func answerOnTap(_ sender: UIButton) {
        guard let correctAnswer = self.question?.correctAnswer else {
            animateIsWrongAnswer()
            return
        }
        
        if sender.currentTitle == correctAnswer {
            animateIsCorrectAnswer()
        } else {
            animateIsWrongAnswer()
        }
    }
    
    func setupQuestion(_ question: Question?) {
        guard let question = question else {
            return
        }
        
        let answers = sortAnswersRandomly(question: question)
        
        zip(answers, answersButtons).forEach { answer, button in
            button.setTitle(answer, for: .normal)
        }
        
    }
    
    func sortAnswersRandomly(question: Question) -> [String] {
        let correctPosition = Int(arc4random_uniform(3))
        var allQuestions = question.incorrectAnswers
        allQuestions.insert(question.correctAnswer, at: correctPosition)
        return allQuestions
    }
    
    func animateIsCorrectAnswer() {
        print("yay! It's correct")
        navigateToNextQuestion()
    }
    
    func animateIsWrongAnswer() {
        print("Oops! Incorrect answer")
        navigateToNextQuestion()
    }
    
    func navigateToNextQuestion() {
        let currentQuestionPosition = self.fullQuizz!.questions.index(of: self.question!)!
        
        if currentQuestionPosition == self.fullQuizz!.questions.count - 2 {
            self.performSegue(withIdentifier: "resultScreenSegue", sender: nil)
        } else {
            let nextView = self.storyboard?.instantiateViewController(withIdentifier: "quizzViewController") as! QuizViewController
            nextView.score = self.score + 1
            nextView.question = self.fullQuizz?.questions[currentQuestionPosition + 1]
            nextView.fullQuizz = self.fullQuizz
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
}
