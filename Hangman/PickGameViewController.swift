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
    //var name: String = ""
    
    @IBOutlet weak var hangManImg: UIImageView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var enterNameBtn: UIButton!
    
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var standardBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusWheel: UIActivityIndicatorView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        easyBtn.isSelected = false
        standardBtn.isSelected = false
        hardBtn.isSelected = false
        goButton.isHidden = true
        nameLabel.text = ""
        enterNameBtn.isHidden = true
        playerName.text = "Enter New Player"
        playerName.textColor = UIColor.lightGray
        
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
        
        subscribeToKeyboardNotifications()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterNameBtn.isHidden = false
        self.playerName.delegate = self
        playerName.textColor = UIColor.black
        easyBtn.backgroundColor = UIColor.red
        standardBtn.backgroundColor = UIColor.red
        hardBtn.backgroundColor = UIColor.red
        easyBtn.titleLabel?.textColor = UIColor.black
        standardBtn.titleLabel?.textColor = UIColor.black
        hardBtn.titleLabel?.textColor = UIColor.black
        statusWheel.hidesWhenStopped = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
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
                let name = users.endIndex
                print(name)
                nameLabel.text = "HEY \(player.user as AnyObject)"
                users.append(player)
            }
        
        } catch{}
    }
    
    
    @IBAction func startGame(_ sender: Any) {
        
        
    }
    
    @IBAction func easyGame(_ sender: Any) {
        let easy = max(Int(arc4random_uniform(5) + 1), 3)
        print(easy)
        easyBtn.isSelected = true
        standardBtn.isSelected = false
        hardBtn.isSelected = false
        playLevel = String(easy)//count num of characters
        
        self.statusWheel.startAnimating()
        
        playGame()
    }

    @IBAction func standardGame(_ sender: Any) {
        let standard = max(Int(arc4random_uniform(6) + 1), 5)
        print(standard)
        standardBtn.isSelected = true
        easyBtn.isSelected = false
        hardBtn.isSelected = false
        playLevel = String(standard)//count num of characters
        
        self.statusWheel.startAnimating()
        
        playGame()
    }
    
    @IBAction func hardGame(_ sender: Any) {
        let hard = max(Int(arc4random_uniform(9) + 1), 7)
        print(hard)
        hardBtn.isSelected = true
        easyBtn.isSelected = false
        standardBtn.isSelected = false
        playLevel = String(hard)//count num of characters
        
        self.statusWheel.startAnimating()
        
        playGame()
    }
    
    @IBAction func createPlayer(_ sender: Any) {
        
        nameLabel.text = ""
        playerName.resignFirstResponder()
        
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
                nameLabel.text = "Hey \(String(describing: newPlayer.user!))"
                playerName.resignFirstResponder()
                
                DispatchQueue.main.async {
                    AppDelegate.stack.save()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        playerName.text = ""
        playerName.becomeFirstResponder()
        playerName.textColor = UIColor.black
        enterNameBtn.isHidden = false
        enterNameBtn.titleLabel?.textColor = UIColor.black
        enterNameBtn.backgroundColor = UIColor.red
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "game") {
            print("test")
            let controller = segue.destination as! gameBoardController
           
            //MAY DO SOMETHING WITH THIS
            /*
            for player in users {
                //let name = users.endIndex
                print("In the prepare for segue \(String(describing: player.user))")
                name = player.user!
            }
            //let user = users //as? Player
            
            
            controller.player = name */
            controller.word = newWord
        }
    }
    
    // THIS FUNCTION CHECKS TO SEE IF THERE ARE MULTIPLE SINGLE CHARACTERS IN THE WORD AND REQEUST NEW WORD IF THERE IS
    func noDulplicateCharacter(_chkChars: String) {
        let newWordCount = self.newWord.characters.count
        print("New word: \(newWordCount)")
        let distinctWord = Set(self.newWord.characters).count
        print("distinct word: \(distinctWord)")
        
        if newWordCount != distinctWord {
            playGame()
        }
        
        self.statusWheel.stopAnimating()
    }
    
    
    func playGame() {
        
        Networking.sharedInstance().wordRetrieve(playLevel: playLevel) { (success, gameWord, error) in
            
            if success {
        
                self.newWord = gameWord
                self.noDulplicateCharacter(_chkChars: self.newWord)
                self.goButton.isHidden = false
                self.goButton.titleLabel?.textColor = UIColor.black
                self.goButton.backgroundColor = UIColor.red
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
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { action in
            self.playerName.resignFirstResponder() })
        )
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    class func sharedInstance() -> pickGameViewController {
        struct Singleton {
            static var sharedInstance = pickGameViewController()
        }
        return Singleton.sharedInstance
    }
}

extension pickGameViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        playerName.resignFirstResponder()
        return true
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        
        if playerName.isFirstResponder
        {
            return keyboardSize!.cgRectValue.height
        }
            
        else
        {
            return 0
        }
    }
    
    
    func keyboardWillShow(_ notification:Notification)
    {
        view.frame.origin.y = getKeyboardHeight(notification: notification as NSNotification) * (-1)
    }
    
    func keyboardWillHide(_ notification:Notification)
    {
        view.frame.origin.y = 0
    }
    
    
    func subscribeToKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
}




