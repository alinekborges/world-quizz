//
//  QuizzModel.swift
//  world-quizz-base
//
//  Created by Aline Borges on 30/08/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation

struct Quizz: Codable {
    let questions: [Question]
}

struct Question: Codable {
    let imageURL: String
    let time: Int
    let incorrectAnswers: [String]
    let correctAnswer: String
}

extension Question: Equatable {
    static func ==(lhs: Question, rhs: Question) -> Bool {
        return lhs.imageURL == rhs.imageURL &&
            lhs.time == rhs.time &&
            lhs.incorrectAnswers == rhs.incorrectAnswers &&
            lhs.correctAnswer == rhs.correctAnswer
    }
}
