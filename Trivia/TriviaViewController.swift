//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/10/24.
//

import UIKit

class TriviaViewController: UIViewController {
    var triviaQuestions : TriviaQuestions!
    
    @IBOutlet weak var questionField: UILabel!
    
    @IBOutlet weak var answerButton0: UIButton!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionCategory: UILabel!
    
    var settings: TrivisSettings = TrivisSettings()
    
    var questionNumber: Int = 0;
    var score: Int = 0;
    
    override func viewDidLoad() {
        fetchQuestions()
        super.viewDidLoad()
    }
    
    func fetchQuestions(){
            TriviaQuestionsService.fetchQuestions(questionsAmount: settings.questionsAmount, category: settings.category?.rawValue, difficulty: settings.difficulty) { triviaQuestions in
            self.triviaQuestions = triviaQuestions
            self.nextQuestion()
        }
    }
    
    func nextQuestion() {
        if questionNumber > triviaQuestions.questions.count - 1 {
            gameOverAlert()
            return
        }
        let question = triviaQuestions.questions[questionNumber]
        questionField.text = question.question
        
        questionNumberLabel.text = "\(questionNumber + 1)/\(triviaQuestions.questions.count)"
        questionCategory.text = question.category
        
        let answers = question.answers
        
        switch question.type{
        case .boolean: booleanAnswers(answers)
        case .multiple: multipleAnswers(answers)
        }
        
    }
    
    func multipleAnswers(_ answers: [String]){
        answerButton0.setTitle(answers[0], for: UIControl.State.normal)
        answerButton1.setTitle(answers[1], for: UIControl.State.normal)
        answerButton2.setTitle(answers[2], for: UIControl.State.normal)
        answerButton3.setTitle(answers[3], for: UIControl.State.normal)
        answerButton2.isHidden = false
        answerButton3.isHidden = false
    }
    
    func booleanAnswers(_ answers: [String]){
        answerButton0.setTitle(answers[0], for: UIControl.State.normal)
        answerButton1.setTitle(answers[1], for: UIControl.State.normal)
        answerButton2.isHidden = true
        answerButton3.isHidden = true
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        checkAnswer(answer: sender.currentTitle)
        questionNumber+=1
    }
    
    func checkAnswer(answer: String? = ""){
        if answer == triviaQuestions.questions[questionNumber].correctAnswer {
            score += 1
            correctAnswer()
        } else {
            incorrectAnswer()
        }
    }
    
    
    func gameOverAlert() {
        let alert = UIAlertController(title: kGameOver, message: "\(kFinalScore) \(score)/\(triviaQuestions.questions.count)", preferredStyle: .alert)
        
        let restartAction = {
            (_ action: UIAlertAction) in
            self.score = 0
            self.questionNumber = 0
            self.fetchQuestions()
        }
        
        let doneQuiz = { (_ action: UIAlertAction) in
//            self.score = 0
//            self.questionNumber = 0
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        alert.addAction(UIAlertAction(title: kRestart, style: .default, handler: restartAction))
        alert.addAction(UIAlertAction(title: kOk, style: .default, handler: doneQuiz))
        present(alert, animated: true)
    }
    
    
    
    func correctAnswer() {
        let alert = UIAlertController(title: kCongradulation, message: kAddPoint, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kNext, style: .default, handler: nextQuestionHandler))
        present(alert, animated: true)
    }
    
    func incorrectAnswer() {
        let alert = UIAlertController(title: kIncorrectAnswerTitle, message: kIncorrectAnswerMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: kNext, style: .default, handler: nextQuestionHandler))
        present(alert, animated: true)
    }
    
    func nextQuestionHandler(_ action: UIAlertAction){
        nextQuestion()
    }
}
