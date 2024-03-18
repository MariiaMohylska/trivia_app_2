//
//  TriviaQuestionsService.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/17/24.
//

import Foundation

class TriviaQuestionsService {
    
    static func fetchQuestions(questionsAmount: Int = 10, category: Int? = nil, difficulty: String? = nil, completion: ((TriviaQuestions) -> Void)? = nil) {
        var urlRaw = "https://opentdb.com/api.php?amount=\(questionsAmount)"
        
        if category != nil {
            urlRaw.append("&category=\(category!)")
        }
        
        if let difficultyUnwrapped = difficulty {
            urlRaw.append("&difficulty=\(difficultyUnwrapped)")
        }
        
        print("URL: \(urlRaw)")
        let url = URL(string: urlRaw)!
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            
            let decoder = JSONDecoder()
            
            let response = try! decoder.decode(TriviaQuestions.self, from: data)
            
            DispatchQueue.main.async{
                completion?(response)
            }
        }
        
        task.resume()
    }
}
