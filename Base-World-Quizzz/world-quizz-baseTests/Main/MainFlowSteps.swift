//
//  MainFlowSteps.swift
//  world-quizz-baseUITests
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import KIF

//Steps for main flow
extension MainFlowTests {
    
    // MARK: - User Actions
    
    func tapOnStartButton() {
        tapOnView("start_button")
    }
    
    // MARK: - Views expected
    
    func expectToSeeQuizzView() {
        expectToSee("quizz_view")
    }
    
}
