//
//  ViewController.swift
//  WordScramble
//
//  Created by Christopher Myers on 12/29/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "/n")
            }
        } else {
            allWords = ["silkworm"]
        }
        // Do any additional setup after loading the view, typically from a nib.
        startGame()
        //print(allWords)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
        
    }
    func startGame() {
        //allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        
        title = allWords[0]
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        // 1. submitAction is an action (button) with the label of "Submit"
        // 2. The closure {...} is the action to be taken when the user presses the submitAction button
        // 3. everything before the 'in' describes the closure (it is an action of type UIAlertAction)
        // 4. everything after the 'in' is the code to be executed--> submitting the users text
        // 5. since we don't refernce the action anywhere inside the closure, we can just use a _ in place of a name 
        // 6. unowned is similar to implicity unwrapped optional and we declare that self, and are to be
        // capture by the closure as unowned references--> it can use them but doesn't make strong reference cycles
        // because the closure doesn't own them.
        
        // This is placeholder for a change i'll make shortly.
        
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(answer : String) {
        
        let lowerAnswer = answer.lowercased()
        
        let errorTitle : String
        let errorMessage : String
        
        
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                } else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word already used"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
    func isPossible(word : String) -> Bool {
        
        var tempWord = title!.lowercased()
        
        for letter in word.characters {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word : String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word : String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }


}

