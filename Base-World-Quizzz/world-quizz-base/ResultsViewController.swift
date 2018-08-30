//
//  ResultsViewController.swift
//  world-quizz-base
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var result: Int = 0
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resultsLabel.text = String(result)
    }
    
    @IBAction func playAgainOnClick(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
