//
//  ListViewController.swift
//  DocumentsCoreData
//
//  Created by Nathaniel Banderas on 7/6/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var documentTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var documents = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.timeStyle = .long
        dateFormatter.dateStyle = .long
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do {
            documents = try managedContext.fetch(fetchRequest)
            documentTableView.reloadData()
        } catch {
            print("Fetch could not be performed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewExpense(_ sender: Any) {
        performSegue(withIdentifier: "showExpense", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        let document = documents[indexPath.row]
        
        cell.textLabel?.text = document.name
        if let date = document.date {
              cell.detailTextLabel?.text = dateFormatter.string(from: date)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDocument", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DocumentViewController,
            let selectedRow = self.documentTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.existingDocument = documents[selectedRow]
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        let document = documents[indexPath.row]
        
        if let managedContext = document.managedObjectContext {
                managedContext.delete(document)
            
            do {
                try managedContext.save()
                
                self.documents.remove(at: indexPath.row)
                documentTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("delete failed")
                
                documentTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteDocument(at: indexPath)
        }
    }
}
