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
    @IBOutlet weak var imageView: UIImageView!
    
    var word: String!
    var characterCount: Int = 0
    var characters = ""
    var numCharacters: Int = 0
    var xPos = 50
    var tag = 0
    var arrChar: [String] = [""]
    var arrTags: [Int] = []
    var aTextField = UITextField()
    var counterForDrawing = 0
    
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
            
            aTextField = UITextField(frame: CGRect(x: xPos, y: 410, width: 30, height: 30))
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
        
        var count = 0
        
        
        for char in arrChar {
            
            if char == selectedLetter {

                let txtLoc = (arrChar.index(of: char))! + 1
                
                if let txtField = self.view.viewWithTag(txtLoc) as? UITextField {
                    txtField.text = char
                    txtField.textColor = UIColor.black
                }
                
            } else {
                
                if count < (numCharacters - 1) {
                     count += 1
                    
                } else {
                    
                    counterForDrawing += 1
                    switch counterForDrawing {
                        
                    case 1:
                        drawLine(from: CGPoint(x: 65, y: 700), to: CGPoint(x: 85, y: 700))  //BASE
                        drawLine(from: CGPoint(x: 65, y: 700), to: CGPoint(x: 75, y: 650))  //BASE
                        drawLine(from: CGPoint(x: 85, y: 700), to: CGPoint(x: 75, y: 650))  //BASE
                        drawLine(from: CGPoint(x: 75, y: 700), to: CGPoint(x: 75, y: 100))  //LEFT VERITCAL BAR
                        drawLine(from: CGPoint(x: 75, y: 100), to: CGPoint(x: 200, y: 100))  //TOP HORIZONTAL BAR
                     
                    case 2:
                        drawLine(from: CGPoint(x: 200, y: 100), to: CGPoint(x: 200, y: 200)) //TOP VERTICAL BAR
                        drawHead() // HEAD
                        
                    case 3:
                        drawLine(from: CGPoint(x: 199, y: 270), to: CGPoint(x: 199, y: 450))  //LEFT LEG
                        
                    case 4:
                        drawLine(from: CGPoint(x: 199, y: 450), to: CGPoint(x: 185, y: 510))  //RIGHT LEG
                        
                    case 5:
                        drawLine(from: CGPoint(x: 199, y: 450), to: CGPoint(x: 215, y: 510))  //BODY
                        
                    case 6:
                        drawLine(from: CGPoint(x: 199, y: 315), to: CGPoint(x: 175, y: 270))  //LEFT ARM
                        
                    case 7:
                        drawLine(from: CGPoint(x: 199, y: 315), to: CGPoint(x: 225, y: 270))  //RIGHT ARM
                        print("GAME OVER - YOU LOSE")
                    
                    default : break
                        
                    }
                }
            }
        }
    }
}
