//
//  ResultsController.swift
//  Hangman
//
//  Created by Kevin Reese on 5/17/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class resultsController: UITableViewController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.setNavigationBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setNavigationBar() {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "RESULTS")
        let backItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(back))
        navItem.leftBarButtonItem = backItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    func back() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // this viewcontroller will be used to display the wins and loses; the data displayed here will be 
    // from coredata
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)
        
        cell.textLabel?.text = "This is a test"
        
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "This section"
    }
    
    */
    
    
    
    
    
    
    
}

