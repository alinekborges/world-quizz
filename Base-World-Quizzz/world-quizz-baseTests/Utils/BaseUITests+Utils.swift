//
//  BaseUITests+Utils.swift
//  world-quizz-baseUITests
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import UIKit
import KIF

class BaseUITest: KIFTestCase { }

extension BaseUITest {
    
    func expectToSee(_ text: String) {
        tester().waitForView(withAccessibilityIdentifier: text)
    }
    
    func expectNotToSee(_ text: String) {
        tester().waitForAbsenceOfView(withAccessibilityIdentifier: text)
    }
    
    func tapOnView(_ accessibilityIdentifier: String) {
        tester().tapView(withAccessibilityIdentifier: accessibilityIdentifier)
    }
    
    func getView(_ text: String) -> UIView {
        return tester().waitForView(withAccessibilityLabel: text)
    }
    
    func insertText(_ text: String, intoView view: String) {
        tester().enterText(text, intoViewWithAccessibilityIdentifier: view)
    }
    
    func expect(_ accessibilityIdentifier: String, toContainText text: String) -> String {
        tester().expect(accessibilityIdentifier, toContainText: text)
    }
}
