//
//  DocumentViewController.swift
//  DocumentsCoreData
//
//  Created by Nathaniel Banderas on 7/6/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var existingDocument: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nameTextField.delegate = self
//        contentTextView = self
        
        nameTextField.text = existingDocument?.name
        contentTextView.text = existingDocument?.content
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        let name = nameTextField.text
        let contentText = contentTextView.text ?? ""
        let date = Date()
        let size = 0
        
        var document: Document?
        
        if let existingDocument = existingDocument {
            existingDocument.name = name
            existingDocument.content = contentText
            existingDocument.date = date
            existingDocument.size = 0
            
            document = existingDocument
        } else {
            document = Document(name: name, content: contentText, size: Int64(size), date: date)
        }
        
        if let document = document {
            do {
                let managedContext = document.managedObjectContext
                try managedContext?.save()
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Document could not be saved")
            }
        }
    }
}
