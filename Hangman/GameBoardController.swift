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
    
    var word: String!
    var characterCount: Int = 0
    var characters = ""
    var numCharacters: Int = 0
    var xPos = 50
    var tag = 0
    var arrChar: [String] = [""]
    var arrTags: [Int] = []
    var aTextField = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        countOfWord(word)
        self.testTextField.delegate = self
        testTextField.becomeFirstResponder()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // THIS CREATES THE TEXTFIELDS BASED OFF OF WORD AND REVEALS LETTERS AS SELECTED CORRECTLY
        
        arrChar = word.uppercased().characters.map{String($0)}
        
        for num in (arrChar) {
            
            tag += 1
            
            aTextField = UITextField(frame: CGRect(x: xPos, y: 100, width: 20, height: 20))
            aTextField.backgroundColor = UIColor.green
            aTextField.textColor = UIColor.green
            aTextField.textAlignment = .center
            aTextField.tag = tag
            arrTags.append(aTextField.tag)
            aTextField.text = num
            
            xPos += 50
            
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
    
    // MAY NOT USE THIS FUNCTION
    
    func countOfWord(_ wordCount: String) {
        
        numCharacters = word.characters.count
    }
    
    // THIS GETS LETTER SELECTED AND COMPARES TO LETTERS IN TEXTFIELD
    
    func something(_ selectedLetter: String) {
    
        for char in arrChar {
            
            if char == selectedLetter {
               // NEED TO DO SOMETHING TO CHECK FOR MULTIPLE OF THE SAME CHARACTER
                let txtLoc = (arrChar.index(of: char))! + 1
                
                
                if let txtField = self.view.viewWithTag(txtLoc) as? UITextField {
                    txtField.text = char
                    txtField.textColor = UIColor.black
                    
                } else {
                    
                    // HERE A METHOD WILL BE CALLED TO START DRAWING THE HANGMAN PIC; WILL DO IN ANOTHER FILE
                }
            }
        }
    }
}
