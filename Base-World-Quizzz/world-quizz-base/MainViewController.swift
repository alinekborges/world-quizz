//
//  ViewController.swift
//  world-quizz-base
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var quizz: Quizz?
    
    let url = "https://gist.githubusercontent.com/alinekborges/3b1d1be3f286601d09af131fb0fb1cdf/raw/6028079c7da181385bd9fc6f4a756431a6951f10/sample-quizz.json"
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.activityIndicator.isHidden = true
        self.errorLabel.isHidden = true
        self.activityIndicator.accessibilityIdentifier = "loading_view"
    }
    
    @IBAction func playButtonTap(_ sender: Any) {
        self.downloadQuizz()
    }
    
    func downloadQuizz() {
        
        self.playButton.alpha = 0.4
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        //self.playButton.isUserInteractionEnabled = false
        
        Alamofire.request(url).responseData { response in
            
            self.playButton.alpha = 1
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
            if response.response?.statusCode == 200, let data = response.data {
                let decoder = JSONDecoder()
                let quizz = try? decoder.decode(Quizz.self, from: data)
                self.quizz = quizz
                self.performSegue(withIdentifier: "startQuizzSegue", sender: nil)
            } else {
                //show error
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startQuizzSegue" {
            let destination = segue.destination as! QuizViewController
            destination.fullQuizz = self.quizz
            destination.question = self.quizz?.questions[0]
        }
    }
    
}

