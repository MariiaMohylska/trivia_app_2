//
//  TriviaSettings.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/17/24.
//

import Foundation

struct TrivisSettings {
    let questionsAmount: Int
    let difficulty: String?
    let category: Category?
    
    init(questionsAmount: Int = 10, difficulty: String? = nil, category: Category? = nil) {
        self.questionsAmount = questionsAmount
        self.difficulty = difficulty
        self.category = category
    }
}
