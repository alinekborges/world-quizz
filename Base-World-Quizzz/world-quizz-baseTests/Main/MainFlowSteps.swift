//
//  MainFlowSteps.swift
//  world-quizz-baseUITests
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import KIF
import OHHTTPStubs

//Steps for main flow
extension MainFlowTests {
    
    func mockAPI() {
        stub(condition: isHost("gist.githubusercontent.com")) { _ in
            let stubPath = OHPathForFile("MockQuizzData.json", type(of: self))
            return fixture(filePath: stubPath!, headers: nil)
                .responseTime(0.5)
        }
    }
    
    func mockAPINotConnected() {
        stub(condition: isHost("gist.githubusercontent.com")) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue)
            return OHHTTPStubsResponse(error:notConnectedError)
        }
    }
    
    // MARK: - User Actions
    
    func tapOnStartButton() {
        tapOnView("start_button")
    }
    
    func tapCorrectAnswer() {
        tapOnView("correct")
    }
    
    func tapIncorrectAnswer() {
        tapOnView("incorrect")
    }
    
    // MARK: - Views expected
    
    func expectToSeeQuizzView() {
        expectToSee("quizz_view")
    }
    
    func expectToSeeErrorView() {
        expectToSee("error_view")
    }
    
    func expectToSeeSuccessView() {
        expectToSee("success_view")
    }
    
    func getScore() -> Int {
        let view = tester().waitForView(withAccessibilityIdentifier: "score_label") as! UILabel
        return Int(view.text!)!
    }
    
}
