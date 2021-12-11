//
//  NotesViewController.swift
//  Assignment10
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    var Notes:String?
    
    private let NameLabel : UILabel = {
        let label = UILabel()
        label.text = "File Name : "
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.shadowColor = .black
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder =
            NSAttributedString(string: "Enter Your Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        textField.text = ""
        textField.textColor = .white
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        //textField.layer.cornerRadius = 15
        return textField
    }()
    
    private let contentTextView : UITextView = {
        let TextView = UITextView()
        TextView.text = ""
        TextView.font = UIFont(name: "HoeflerText-BlackItalic", size: 15)
        TextView.textAlignment = .left
        TextView.backgroundColor = .clear
        TextView.textColor = .white
        TextView.layer.borderWidth = 5
        TextView.layer.borderColor = UIColor.white.cgColor
        return TextView
    }()
    
    public let saveButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save Note", for: .normal)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.backgroundColor = UIColor(cgColor: UIColor.white.cgColor)
        button.layer.cornerRadius = 20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    @objc private func saveNote() {
        let name = nameTextField.text!
        let content = contentTextView.text!
        let filePath = FileManagerService.getDocDir().appendingPathComponent("\(name).txt")
        
        do {
            try  content.write(to: filePath, atomically: true, encoding: .utf8)
            
        }catch {
            print(error)
        }
    }
    
    public func deleteNote(name: String) {
        let filePath = FileManagerService.getDocDir().appendingPathComponent("\(name)")
        
        do {
            try  FileManager.default.removeItem(at: filePath)
            
        }catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!)
        view.addSubview(NameLabel)
        view.addSubview(nameTextField)
        view.addSubview(contentTextView)
        view.addSubview(saveButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        do{
            if let file = Notes {
                nameTextField.text = file
            let filePath = FileManagerService.getDocDir().appendingPathComponent("\(file)")
            let fetchedContent = try String(contentsOf: filePath)
                contentTextView.text = fetchedContent
            print(fetchedContent)
            print(filePath)
           
         }
        } catch {
            print(error)
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NameLabel.frame = CGRect(x: 10, y: 100, width: 100, height: 30)
        nameTextField.frame = CGRect(x: 120, y: 100, width: 240, height: 30)
        contentTextView.frame = CGRect(x: 10, y: 160, width: view.frame.size.width - 15, height: 300)
        saveButton.frame = CGRect(x: 40, y: 480 , width: view.frame.size.width-80, height: 40)
    }
    
    
}
