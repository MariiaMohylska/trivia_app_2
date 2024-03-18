//
//  SettingsViewController.swift
//  Trivia
//
//  Created by Mariia Mohylska on 3/17/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var difficultyButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var questionAmountTextField: UITextField!
    
    var difficulty: String? = nil
    var category: Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionMenuInit()
        // Do any additional setup after loading the view.
    }
    
    func actionMenuInit(){
        let difficulties = ["any", "easy", "medium", "hard"]
        let categories = Category.allCases

        let difficultyActionClosure = {
            (action: UIAction) in
            if action.title != difficulties.first { self.difficulty = action.title} else {self.difficulty = nil}
        }
        
        let categoryActionClosure = {
            (action: UIAction) in 
            let rawValue = Category.rawValueFromDescription(action.title)
            self.category = rawValue == nil ? nil : Category(rawValue: rawValue!)
        }
        
        var difficultyMenuItems: [UIMenuElement] = []
        for difficulty in difficulties{
            difficultyMenuItems.append(UIAction(title: difficulty, handler: difficultyActionClosure))
        }
        
        var categoryMenuItems: [UIMenuElement] = []
        
        categoryMenuItems.append(UIAction(title: "Any", handler: categoryActionClosure))
        for category in categories {
            categoryMenuItems.append(UIAction(title: category.description, handler: categoryActionClosure))
        }
        
        difficultyButton.menu = UIMenu(options: .displayInline, children: difficultyMenuItems)
        categoryButton.menu = UIMenu(options: .displayInline, children: categoryMenuItems)
        
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        if let amount = Int(questionAmountTextField.text ?? "") {
            startQuiz(questionAmount: amount)
        } else {
            incorrectAmountAlert()
        }
    }
    
    func startQuiz(questionAmount: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let triviaViewController = storyboard.instantiateViewController(withIdentifier: "TriviaViewController") as! TriviaViewController
        triviaViewController.settings = TrivisSettings(questionsAmount: questionAmount, difficulty: difficulty ,category: category)
        navigationController?.pushViewController(triviaViewController, animated: true)
    }
    
    func incorrectAmountAlert(){
        let alert = UIAlertController(title: "Incorrect number of questions!", message: "We will set default value of 10", preferredStyle: .alert)
        
        let alertHandler = {(action:UIAlertAction) in self.startQuiz(questionAmount: 10)}
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: alertHandler))
        present(alert, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
