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
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(answer : String) {
        
        
        
    }


}

