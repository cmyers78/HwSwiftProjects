//
//  ViewController.swift
//  SwiftyWords
//
//  Created by Christopher Myers on 1/5/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score : Int = 0 {
        // property observer to update score everytime score value changes
        didSet {
            scoreLabel.text = "Score : \(score)"
        }
    }
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews where subview.tag == 1001 {
            // finds views with tag 1001 and typecasts as UIButton
            let btn = subview as! UIButton
            letterButtons.append(btn)
            // addTarget is the programatic way of ctrl dragging in storyboard
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        
        loadLevel()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func letterTapped(btn : UIButton) {
        // update the current answer field
        currentAnswer.text = currentAnswer.text! + (btn.titleLabel!.text)!
        // add the button tapped to the activatedButton array
        activatedButtons.append(btn)
        // disable (hide) the button tapped
        btn.isHidden = true
        
        
    }

    func loadLevel() {
        var clueString = ""
        var solutionsString = ""
        var letterBits = [String]()
        
        // Step 1 : find and load the level string from disk
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                
                // Step 2 : split text into an array separted by new lines (\n) and shuffle the array every time 
                // the game is played
                
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                // Step 3 : Loop through the shuffled lines array
                for (index, line) in lines.enumerated() {
                    // Step 4 : split each line up into a new array separated by : beofre the colon is the answer, after is the clue
                    let parts = line.components(separatedBy: ":")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    // Step 5 : creates a string with the clue index number in the array (starting from zero
                    // and setting it to be 1, followed by the actual clue -> (i.e. '1. clue text')
                    clueString += "\(index + 1).\(clue)\n"
                    
                    // Step 6 : remove the | and replace with empty string so HA|UNT|ED becomes HAUNTED
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    // Step 7 : find how long the solution is supposed to be and offer it as hint
                    // i.e. '8 letters'
                    solutionsString += "\(solutionWord.characters.count) letters\n"
                    print(solutionsString)
                    
                    // Step 8 : append the solution word string to the solutions array
                    solutions.append(solutionWord)
                    // Step 9 : take the answer string, throw it into an array but separate the answer using |
                    // i.e  'HA|UNT|ED' becomes [HA, UNT, ED]
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        // Now configure the buttons and labels
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionsString.trimmingCharacters(in: .whitespacesAndNewlines)
        //print(answersLabel.text)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        // If the number of items in the letterBits array == number of UIButtons in the letterButtons array, then proceed and place the text in each position in the letterBits array as the title of the buttons
        if letterBits.count == letterButtons.count {
            for i in 0..<letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    func levelUp(action : UIAlertAction) {
        
        if level < 2 {
        level += 1
       
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
        } else {
            level = 1
            solutions.removeAll(keepingCapacity: true)
            loadLevel()
            for btn in letterButtons {
                btn.isHidden = false
            }
        }
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
        // Step 1 : find the position of the array that has the user's current answer and clear the activateButtons array
        if let solutionsPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            
            // Step 2 : split all the answerLabel texts into an array, separated by new lines
            var splitCues = answersLabel.text!.components(separatedBy: "\n")
            // Step 3 : Change the hint text to the currentAnswer text at the correct index position in the splitCues array (i.e. '7 letters' -> 'HAUNTED')
            splitCues[solutionsPosition] = currentAnswer.text!
            // Step 4 : takes the splitCues array and turns it back into a string to update the answersLabel.text
            answersLabel.text = splitCues.joined(separator: "\n")
            
            // Step 5 : Clears out the textfield
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
            
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        
        currentAnswer.text = ""
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
}

