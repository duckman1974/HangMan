//
//  DrawHangMan.swift
//  Hangman
//
//  Created by Kevin Reese on 6/1/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit


extension gameBoardController {
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        
        imageView.image?.draw(in: view.bounds)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(4.0)
        context?.setStrokeColor(UIColor.black.cgColor)
        //context?.setBlendMode(CGBlendMode.normal)
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        //imageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    func drawHead() {
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: 180, y: 139 ), radius: CGFloat(15), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        
        
        view.layer.addSublayer(shapeLayer)
    }
}
