//
//  ViewController.swift
//  world-quizz-base
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var quizz: Quizz?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func playButtonTap(_ sender: Any) {
        self.downloadQuizz()
    }
    
    func downloadQuizz() {
        let question1 = Question(imageURL: "",
                                 time: 100,
                                 incorrectAnswers: ["Canada", "USA"],
                                 correctAnswer: "Australia")
        
        let question2 = Question(imageURL: "",
                                 time: 100,
                                 incorrectAnswers: ["France", "UK"],
                                 correctAnswer: "Portugal")
        
        self.quizz = Quizz(questions: [question1, question2])
        
        self.performSegue(withIdentifier: "startQuizzSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQuizzSegue" {
            let destination = segue.destination as! QuizViewController
            destination.fullQuizz = self.quizz
            destination.question = self.quizz?.questions[0]
        }
    }
    
}

