//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/10/24.
//

import UIKit

class TriviaViewController: UIViewController {
    let triviaQuestions : TriviaQuestions = TriviaQuestions()
    
    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var answerButton0: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionCategory: UILabel!
    var questionNumber: Int = 0;
    var score: Int = 0;
    
    override func viewDidLoad() {
        nextQuestion()
        super.viewDidLoad()
    }
    
    func nextQuestion() {
        if questionNumber > triviaQuestions.questions.count - 1 {
            gameOverAlert()
            return
        }
        
        questionField.text = triviaQuestions.questions[questionNumber]
        
        questionNumberLabel.text = "\(questionNumber + 1)/\(triviaQuestions.questions.count)"
        questionCategory.text = triviaQuestions.questionCategoryies[questionNumber]
        
        answerButton0.setTitle(triviaQuestions.answers[questionNumber][0], for: UIControl.State.normal)
        answerButton1.setTitle(triviaQuestions.answers[questionNumber][1], for: UIControl.State.normal)
        answerButton2.setTitle(triviaQuestions.answers[questionNumber][2], for: UIControl.State.normal)
        answerButton3.setTitle(triviaQuestions.answers[questionNumber][3], for: UIControl.State.normal)
    }

    @IBAction func ansewerButtonPressed(_ sender: UIButton) {
        checkAnswer(answer: sender.currentTitle)
        questionNumber+=1
        nextQuestion()
    }
    
    func checkAnswer(answer: String? = ""){
        if answer == triviaQuestions.correctAnswers[questionNumber] {
            score += 1
        }
    }
    
    
    func resetAction(_ action: UIAlertAction) {
        score = 0
        questionNumber = 0
        nextQuestion()
    }
    
    func gameOverAlert() {
        let alert = UIAlertController(title: kGameOver, message: "\(kFinalScore) \(score)/\(triviaQuestions.questions.count)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: kRestart, style: .default, handler: resetAction))
        present(alert, animated: true)
    }
}
