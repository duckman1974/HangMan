//
//  PickGameViewController.swift
//  Hangman
//
//  Created by Kevin Reese on 5/15/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class pickGameViewController: UIViewController, UITextFieldDelegate {
    
    let easy: Int = 0
    let standard: Int = 0
    let hard: Int = 0
    var users = [Player]()
    var playLevel = ""
    var exist: Bool = false
    var newWord: String = ""
    
    @IBOutlet weak var hangManImg: UIImageView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var enterNameBtn: UIButton!
    
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var standardBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    @IBOutlet weak var goButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        easyBtn.isSelected = false
        standardBtn.isSelected = false
        hardBtn.isSelected = false
        goButton.isHidden = true
        
        let fc = fetchedResultsController
        do{
            try fc?.performFetch()
            print(fc?.fetchedObjects?.count as AnyObject)
            if fc?.fetchedObjects?.count == 0 {
                easyBtn.isEnabled = false
                standardBtn.isEnabled = false
                hardBtn.isEnabled = false
                
            }else {
                retrieveUsers()
            }
    
        }catch{
            print("error fetching results")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterNameBtn.isHidden = false
        
        self.playerName.delegate = self
        playerName.text = "Enter New User Here"
    }
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "user", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    
    func retrieveUsers() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        
        do {
            let results = try AppDelegate.stack.context.fetch(fetchRequest)
            let  players = results as! [Player]
    
            for player in players {
                print(player.user as AnyObject)
                users.append(player)
            }
        } catch{}
    }
    
    @IBAction func startGame(_ sender: Any) {
        
        
    }
    
    @IBAction func easyGame(_ sender: Any) {
        let easy = max(Int(arc4random_uniform(6) + 1), 3)
        print(easy)
        easyBtn.isSelected = true
        standardBtn.isSelected = false
        hardBtn.isSelected = false
        goButton.isHidden = false
        playLevel = String(easy)//count num of characters
        
        playGame()
    }

    @IBAction func standardGame(_ sender: Any) {
        let standard = max(Int(arc4random_uniform(8) + 1), 5)
        print(standard)
        standardBtn.isSelected = true
        easyBtn.isSelected = false
        hardBtn.isSelected = false
        goButton.isHidden = false
        playLevel = String(standard)//count num of characters
        
        playGame()
    }
    
    @IBAction func hardGame(_ sender: Any) {
        let hard = max(Int(arc4random_uniform(13) + 1), 7)
        print(hard)
        hardBtn.isSelected = true
        easyBtn.isSelected = false
        standardBtn.isSelected = false
        goButton.isHidden = false
        playLevel = String(hard)//count num of characters
        
        playGame()
    }
    
    @IBAction func createPlayer(_ sender: Any) {
        if ((playerName.text?.isEmpty)!) {
            errorAlert(errorString: "Please create a User")
            
        }else if (playerName.text == "Enter New User Here") {
            errorAlert(errorString: "Please create a User")
            
        
        }else {
            
            let user = playerName.text
            let entity = NSEntityDescription.entity(forEntityName: "Player", in: AppDelegate.stack.context)
            let newPlayer = Player(entity: entity!, insertInto: AppDelegate.stack.context)
            
            for player in users {
                if player.user == user {
                    exist = true
                    DispatchQueue.main.async {
                        self.errorAlert(errorString: "Player already exist")
                    }
                }
            }
            
            if exist == false {
                newPlayer.setValue(user, forKey: "user")
                
                easyBtn.isEnabled = true
                standardBtn.isEnabled = true
                hardBtn.isEnabled = true
                playerName.text = ""
                enterNameBtn.isHidden = true
                
                DispatchQueue.main.async {
                    AppDelegate.stack.save()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        playerName.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "game") {
            print("test")
            let controller = segue.destination as! gameBoardController
            
            controller.word = newWord
        }
    }
    
    func playGame() {
        
        Networking.sharedInstance().wordRetrieve(playLevel: playLevel) { (success, gameWord, error) in
            
            if success {
                
                self.newWord = gameWord
                print("PGVC: \(self.newWord)")
                
            }else{
                print("error getting word")
            }
        }
    }
}

extension pickGameViewController: UITextViewDelegate {
    
    func errorAlert(errorString: String) {
        let alertController = UIAlertController(title: "ALERT", message: errorString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    class func sharedInstance() -> pickGameViewController {
        struct Singleton {
            static var sharedInstance = pickGameViewController()
        }
        return Singleton.sharedInstance
    }
}




