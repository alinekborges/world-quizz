//
//  QuizzViewTest.swift
//  world-quizz-baseUITests
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import KIF
import OHHTTPStubs
@testable import world_quizz_base

class MainFlowTests: BaseUITest {
    
    override func beforeEach() {
        super.beforeEach()
        self.mockAPI()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
    }
    
    func test_clickStart_shouldGo_Quizz() {
        tapOnStartButton()
        expectToSeeQuizzView()
    }
    
}

