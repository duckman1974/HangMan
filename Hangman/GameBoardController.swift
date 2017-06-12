//
//  GameBoardController.swift
//  Hangman
//
//  Created by Kevin Reese on 5/17/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class gameBoardController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var testTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var view2: UIView?
    var word: String!
    var characterCount: Int = 0
    var characters = ""
    var numCharacters: Int = 0
    var xPos = 30
    var yPos = 0
    var tag = 0
    var arrChar: [String] = [""]
    var arrTags: [Int] = []
    var aTextField = UITextField()
    var counterForDrawing = 0
    var counterForCorrectLetter = 0
    
    var user = pickGameViewController.sharedInstance().users
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        countOfWord(word)
        self.testTextField.delegate = self
        testTextField.becomeFirstResponder()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        imageView.backgroundColor = UIColor.black
        view.backgroundColor = UIColor.gray
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBar()
        
        fetchedResultsController?.delegate = self as? NSFetchedResultsControllerDelegate
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        print("Width: \(screenWidth)")
        print("Height: \(screenHeight)")
        
        if screenHeight <= 568 {
            
            yPos = 275
            
        } else {
            
            yPos = 400
        }
        
        if word.characters.count <= 5 {
            
            xPos = 70
            
        } else {
            
            xPos = 30
        }
        
        
        // THIS CREATES THE TEXTFIELDS BASED OFF OF WORD AND REVEALS LETTERS AS SELECTED CORRECTLY
        
        arrChar = word.uppercased().characters.map{String($0)}
        
        for num in (arrChar) {
            
            tag += 1
            
            aTextField = UITextField(frame: CGRect(x: xPos, y: yPos, width: 30, height: 30))
            aTextField.backgroundColor = UIColor.black
            aTextField.textColor = UIColor.black
            aTextField.textAlignment = .center
            aTextField.tag = tag
            arrTags.append(aTextField.tag)
            aTextField.text = num
            
            xPos += 40
        
            view.addSubview(aTextField)
        }
        
        testTextField.textColor = UIColor.gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      
       testTextField.resignFirstResponder()
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Results")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "results", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    
    func setNavigationBar() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 55))
        let navItem = UINavigationItem(title: "")
        let resultsItem = UIBarButtonItem(title: "Results", style: .plain, target: nil, action: #selector(results))
        let backItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        navItem.rightBarButtonItem = resultsItem
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func countOfWord(_ wordCount: String) {
        
        numCharacters = word.characters.count
    }
    
    func back() {
        _ = navigationController?.popToRootViewController(animated: false)
    }
    
    func results() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ResultsController") as! resultsController
        present(controller, animated: true, completion: nil)
    }

    // THIS GETS LETTER SELECTED AND COMPARES TO LETTERS IN TEXTFIELD
    
    func something(_ selectedLetter: String) {
        
        var count = 0
        
        for char in arrChar {
            
            if char == selectedLetter {

                let txtLoc = (arrChar.index(of: char))! + 1
                
                if let txtField = self.view.viewWithTag(txtLoc) as? UITextField {
                    txtField.text = char
                    txtField.textColor = UIColor.white
                    
                    counterForCorrectLetter += 1
                }
                
                if counterForCorrectLetter == numCharacters {
                    
                    DispatchQueue.main.async {
                        print("YOU WIN!!")
                        self.winGame()
                    }
                }
                
            } else {
                
                if count < (numCharacters - 1) {
                     count += 1
                    
                } else {
                    
                    counterForDrawing += 1
                    switch counterForDrawing {
                        
                    case 1:
                        drawLine(from: CGPoint(x: 65, y: 730), to: CGPoint(x: 85, y: 730))  //BASE
                        drawLine(from: CGPoint(x: 65, y: 730), to: CGPoint(x: 75, y: 680))  //BASE
                        drawLine(from: CGPoint(x: 85, y: 730), to: CGPoint(x: 75, y: 680))  //BASE
                        drawLine(from: CGPoint(x: 75, y: 730), to: CGPoint(x: 75, y: 200))  //LEFT VERITCAL BAR
                        drawLine(from: CGPoint(x: 75, y: 200), to: CGPoint(x: 200, y: 200))  //TOP HORIZONTAL BAR
                     
                    case 2:
                        drawLine(from: CGPoint(x: 200, y: 200), to: CGPoint(x: 200, y: 300)) //TOP VERTICAL BAR
                        drawHead() // HEAD
                        
                    case 3:
                        drawLine(from: CGPoint(x: 200, y: 300), to: CGPoint(x: 200, y: 480))  //BODY
                        
                    case 4:
                        drawLine(from: CGPoint(x: 200, y: 480), to: CGPoint(x: 185, y: 510))  //LEFT LEG
                        
                    case 5:
                        drawLine(from: CGPoint(x: 200, y: 480), to: CGPoint(x: 215, y: 510))  //RIGHT LEG
                        
                    case 6:
                        drawLine(from: CGPoint(x: 200, y: 420), to: CGPoint(x: 170, y: 380))  //LEFT ARM
                        
                    case 7:
                        drawLine(from: CGPoint(x: 200, y: 420), to: CGPoint(x: 230, y: 380))  //RIGHT ARM
                        print("GAME OVER - YOU LOSE")
                        loseGame()
                        
                    default : break
                        
                    }
                }
            }
        }
    }
}

extension gameBoardController {
    
    func loseGame() {
        let entity = NSEntityDescription.entity(forEntityName: "Results", in: AppDelegate.stack.context)
        let lose = Results(entity: entity!, insertInto: AppDelegate.stack.context)
        
        lose.setValue(1, forKey: "loses")
    
        AppDelegate.stack.save()
        
        DispatchQueue.main.async {
            self.loseAlert(alertString: "WORD: \(self.word.uppercased())")
        }
    }
    
    func winGame() {
        let entity = NSEntityDescription.entity(forEntityName: "Results", in: AppDelegate.stack.context)
        let lose = Results(entity: entity!, insertInto: AppDelegate.stack.context)
        
        lose.setValue(1, forKey: "wins")
        
        AppDelegate.stack.save()
        
        DispatchQueue.main.async {
            self.winAlert(alertString: "WORD: \(self.word.uppercased())")
        }
    }
}

extension gameBoardController {
    
    func loseAlert(alertString: String) {
        let alertController = UIAlertController(title: "YOU LOSE!", message: alertString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { action in
            self.navigationController?.popViewController(animated: true)})
            )
        self.present(alertController, animated: true, completion: nil)
    }
    
    func winAlert(alertString: String) {
        let alertController = UIAlertController(title: "YOU WON!", message: alertString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { action in
            self.navigationController?.popViewController(animated: true)})
        )
        self.present(alertController, animated: true, completion: nil)
    }
}
