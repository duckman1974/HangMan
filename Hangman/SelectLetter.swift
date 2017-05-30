//
//  SelectLetter.swift
//  Hangman
//
//  Created by Kevin Reese on 5/27/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit

extension gameBoardController {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let letter: String = string
        
        switch letter {
            
        case "A":
            something("A")
        case "B":
            something("B")
        case "C":
            something("C")
        case "D":
            something("D")
        case "E":
            something("E")
        case "F":
            something("F")
        case "G":
            something("G")
        case "H":
            something("H")
        case "I":
            something("I")
        case "J":
            something("J")
        case "K":
            something("K")
        case "L":
            something("L")
        case "M":
            something("M")
        case "N":
            something("N")
        case "O":
            something("O")
        case "P":
            something("P")
        case "Q":
            something("Q")
        case "R":
            something("R")
        case "S":
            something("S")
        case "T":
            something("T")
        case "U":
            something("U")
        case "V":
            something("V")
        case "W":
            something("W")
        case "X":
            something("X")
        case "Y":
            something("Y")
        case "Z":
            something("Z")
        default :
            print("Invalid key pressed")
        }
          return true
    }
}
