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
            return fixture(filePath: stubPath!)
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
    
    // MARK: - Views expected
    
    func expectToSeeQuizzView() {
        expectToSee("quizz_view")
    }
    
    func expectScore(_ score: Int) {
        expect("score_label", toContainText: String(score))
    }
    
}
