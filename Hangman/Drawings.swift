//
//  Drawings.swift
//  Hangman
//
//  Created by Kevin Reese on 5/24/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit


class Drawings: UIView {
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context!.setLineWidth(3.0)
        context!.setStrokeColor(UIColor.black.cgColor)
        
        context!.move(to: CGPoint(x: 400, y: 600))
        context!.addLine(to: CGPoint(x: 600, y: 700))
        
        context!.strokePath()
    }

}
