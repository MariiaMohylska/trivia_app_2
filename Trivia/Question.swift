//
//  Question.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/17/24.
//

import Foundation

struct Question: Decodable {
    let typeRaw: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
    var answers: [String] {
        var answers = incorrectAnswers
        answers.append(correctAnswer)
        
        return answers.shuffled()
    }
    
    var type: QuestionType {
        return QuestionType(rawValue: typeRaw) ?? .multiple
    }
    
    private enum CodingKeys: String, CodingKey {
        case typeRaw = "type"
        case category = "category"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

enum QuestionType: String{
    case multiple = "multiple"
    case boolean = "boolean"
}

enum Category: Int, CaseIterable {
    case general = 9
    case books = 10
    case films = 11
    case music = 12
    case theatres = 13
    case television = 14
    case videoGames = 15
    case boardGames = 16
    case nature = 17
    case computers = 18
    case math = 19
    case mythology = 20
    case sport = 21
    case geography = 22
    case history = 23
    case politics = 24
    case art = 25
    case celebrities = 26
    case animals = 27
    case vehicles = 28
    case comics = 29
    case gadgets = 30
    case anime = 31
    case cartoon = 32
    
    var description: String {
        return switch self{
            case .general: "General Knowledge"
        case .books: "Entertainment: Books"
        case .films: "Entertainment: Film"
        case . music: "Entertainment: Music"
        case .theatres: "Entretainment: Musicals & Theatres"
            
        case .television: "Entertainment: Television"
        case .videoGames:
            "Entertainment: Video Games"
        case .boardGames:
            "Entertainment: Board Games"
        case .nature:
            "Science & Nature"
        case .computers:
            "Science: Computers"
        case .math:
            "Science: Mathematics"
        case .mythology:
            "Mythology"
        case .sport:
            "Sports"
        case .geography:
            "Geography"
        case .history:
            "History"
        case .politics:
            "Politics"
        case .art:
            "Art"
        case .celebrities:
            "Celebrities"
        case .animals:
            "Animals"
        case .vehicles:
            "Vehicles"
        case .comics:
            "Entertainment: Comics"
        case .gadgets:
            "Science: Gadgets"
        case .anime:
            "Entertainment: Japanese Anime & Manga"
        case .cartoon:
            "Entertainment: Cartoon & Animations"
        }
    }
    
    static func rawValueFromDescription(_ description: String?) -> Int? {
        guard description != nil else { return nil}
        
            for caseValue in self.allCases {
                if caseValue.description == description {
                    return caseValue.rawValue
                }
            }
            return nil
        }
}
