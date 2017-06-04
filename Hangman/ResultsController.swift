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


class resultsController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //var results: Results!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        fetchedResultsController?.delegate = self
        
        let fc = fetchedResultsController
        
        do {
            try fc?.performFetch()
            print(fc?.fetchedObjects?.count as AnyObject)
        } catch {
            print("There was an error fetching data")
        }
        
        setNavigationBar()
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
   
     lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>? = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Results")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "wins", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: AppDelegate.stack.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
 
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fc = fetchedResultsController {
            return fc.sections![section].numberOfObjects
            
        }else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let results = fetchedResultsController!.object(at: indexPath) as! Results
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsCell", for: indexPath)
        cell.textLabel?.text = "Game: " + "Win \(results.wins) " + "Lose \(results.loses) "
        
        return cell
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    
        self.tableView.reloadData()
    }
    
    //LOOK INTO THIS METHOD MORE
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if let _ = fetchedResultsController?.managedObjectContext, let results = fetchedResultsController?.object(at: indexPath) as? Results, editingStyle == .delete {
            
            AppDelegate.stack.context.delete(results)
            AppDelegate.stack.save()
            
        }

    }
}


