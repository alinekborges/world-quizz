//
//  QuizViewController.swift
//  world-quizz-base
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class QuizViewController: UIViewController {
    
    var fullQuizz: Quizz?
    var question: Question?
    var score: Int = 0
    var timer: Timer?
    var elapsedTime: Int = 0
    
    @IBOutlet weak var timerFilterView: UIView!
    @IBOutlet var answersButtons: [UIButton]!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var timeFilterConstraint: NSLayoutConstraint!
    @IBOutlet weak var errorLabel: UILabel!
    
    var animator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupQuestion(question)
        self.downloadImage()
    }
    
    func downloadImage() {
        guard let imageString = self.question?.imageURL, let imageURL = URL(string: imageString) else {
            return
        }

        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: imageView.frame.size,
            radius: 20.0
        )
    
        imageView.af_setImage(
            withURL: imageURL,
            filter: filter,
            imageTransition: .crossDissolve(0.2),
            runImageTransitionIfCached: true) { _ in
                self.startTimer()
        }

    }
    
    func startTimer() {
        guard let questionTime = self.question?.time else { return }
        let time = questionTime * 10
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.elapsedTime += 1
            self.timerLabel.text = String(time - self.elapsedTime)
        })
        
        self.animator = UIViewPropertyAnimator(duration: TimeInterval(questionTime), curve: .linear, animations: {
            self.timeFilterConstraint.constant = -self.imageView.frame.height
            self.view.layoutIfNeeded()
        })
        
        animator?.startAnimation()
    }
    
    @IBAction func answerOnTap(_ sender: UIButton) {
        guard let correctAnswer = self.question?.correctAnswer else {
            animateIsWrongAnswer()
            return
        }
        
        self.answersButtons.forEach { button in
            if button.currentTitle! != correctAnswer {
                button.alpha = 0.4
            } else {
                self.showCorrectAnswer(button)
            }
        }
        
        
        if sender.currentTitle == correctAnswer {
            animateIsCorrectAnswer()
        } else {
            animateIsWrongAnswer()
        }
    }
    
    func setupViews() {
        answersButtons.forEach { button in
            button.layer.cornerRadius = 4.0
            button.clipsToBounds = true
        }
        self.successLabel.isHidden = true
        self.errorLabel.isHidden = true
        self.imageView.layer.cornerRadius = 20.0
    }
    
    func setupQuestion(_ question: Question?) {
        guard let question = question else {
            return
        }
        
        let answers = sortAnswersRandomly(question: question)
        
        zip(answers, answersButtons).forEach { answer, button in
            button.setTitle(answer, for: .normal)
            button.accessibilityIdentifier = answer
        }
        
    }
    
    func sortAnswersRandomly(question: Question) -> [String] {
        let correctPosition = Int(arc4random_uniform(3))
        var allQuestions = question.incorrectAnswers
        allQuestions.insert(question.correctAnswer, at: correctPosition)
        return allQuestions
    }
    
    func showCorrectAnswer(_ button: UIButton) {
        button.alpha = 0.4
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseOut, animations: {
            button.alpha = 1.0
        }) { _ in
            
        }
        
    }
    
    func animateIsCorrectAnswer() {
        self.timer?.invalidate()
        self.successLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.successLabel.isHidden = false
        self.score += self.question!.time * 10 - self.elapsedTime
        self.score += 1
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.successLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                self.navigateToNextQuestion()
            })
        }

    }
    
    func animateIsWrongAnswer() {
        self.timer?.invalidate()
        self.errorLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.score += self.question!.time * 10 - self.elapsedTime
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.errorLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
                self.navigateToNextQuestion()
            })
        }
        
    }

    
    func navigateToNextQuestion() {
        let currentQuestionPosition = self.fullQuizz!.questions.index(of: self.question!)!
        
        if currentQuestionPosition == self.fullQuizz!.questions.count - 1 {
            self.performSegue(withIdentifier: "resultScreenSegue", sender: nil)
        } else {
            let nextView = self.storyboard?.instantiateViewController(withIdentifier: "quizzViewController") as! QuizViewController
            nextView.score = self.score
            nextView.question = self.fullQuizz?.questions[currentQuestionPosition + 1]
            nextView.fullQuizz = self.fullQuizz
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultScreenSegue" {
            let destination = segue.destination as! ResultsViewController
            destination.result = self.score
        }
    }
}
