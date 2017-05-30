//
//  Keyboard.swift
//  Hangman
//
//  Created by Kevin Reese on 5/26/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit


protocol KeyboardInputControlDelegate: class {
    func keyboardInputControl( keyboardInputControl:KeyboardInputControl, didPressKey key:Character)
    
}

class KeyboardInputControl: UIControl, UIKeyInput {
    //var hasText: Bool

    
    // MARK: - properties
    
    weak var delegate: KeyboardInputControlDelegate?
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: Selector(("onTouchUpInside:")), for: .touchUpInside)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIView
    
    func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: - methods
    
    dynamic private func onTouchUpInside(sender: KeyboardInputControl) {
        becomeFirstResponder()
    }
    
    // MARK: - UIKeyInput
    
    var text:String = ""

    func hasText() -> Bool {
        return true
    }
    
    
    func insertText(_ text: String) {
        self.text = text
        for ch in text {
            delegate?.keyboardInputControl(self, didPressKey: ch)
        }
    }
    
    func deleteBackward() {
        if !text.isEmpty {
            let newText = text[text.startIndex..<text.index(before: .before)]
            text = newText
        }
    }
}
