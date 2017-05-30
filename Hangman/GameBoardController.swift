//
//  GameBoardController.swift
//  Hangman
//
//  Created by Kevin Reese on 5/17/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit


class gameBoardController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var testTextField: UITextField!
    @IBOutlet weak var guessTextField: UITextField!
    
    var word: String!
    var characterCount: Int = 0
    var characters = ""
    var numCharacters: Int = 0
    var x = 50
    //let num = 1
    var tag = 0
    var arrChar: [String] = [""]
    var aTextField = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        countOfWord(word)
        self.testTextField.delegate = self
        testTextField.becomeFirstResponder()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrChar = word.uppercased().characters.map{String($0)}
        
        for num in (arrChar) {
            
        tag += 1
            
        aTextField = UITextField(frame: CGRect(x: x, y: 100, width: 20, height: 20))
        aTextField.backgroundColor = UIColor.green
        aTextField.textColor = UIColor.green
        aTextField.textAlignment = .center
        aTextField.tag = tag
        aTextField.text = num
            x += 50
            
            print("Letter \(String(describing: aTextField.text)) for tag: \(aTextField.tag)")
        view.addSubview(aTextField)
        }
        
        self.aTextField.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
       testTextField.resignFirstResponder()
        
    }
    
    
    func countOfWord(_ wordCount: String) {
        
        numCharacters = word.characters.count
       /*
        guessTextField.text = String(repeating: "-", count: numCharacters)
        guessTextField.font = UIFont.boldSystemFont(ofSize: 30)
          
        characters = word.uppercased()
        print("Char from countOfWord Func: \(characters)")*/
        /*
        let index = (guessTextField.text?.endIndex)
        print("index of textField: \(String(describing: index))")
 */
    }
    
    func something(_ selectedLetter: String) {
    
        for char in arrChar/*word.characters.indices*/ {
           
            if char == selectedLetter {
                
                print(char)
                
                
                for txt in (aTextField.text?.characters)! {
                    
                    if Character(char) == txt {
                        
                        self.aTextField.text = char
                        self.aTextField.textColor = UIColor.blue
                        
                    }
                }
                
            }
            
        }
 
        
    }
    
}
