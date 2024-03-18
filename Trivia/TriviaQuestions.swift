//
//  TriviaQuestions.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/10/24.
//

import Foundation

struct TriviaQuestions: Decodable{
    let questions: [Question]
    
    private enum CodingKeys: String, CodingKey{
        case questions = "results"
    }
}
