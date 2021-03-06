//
//  AllNotesListViewController.swift
//  Assignment10
//
//  Created by DCS on 11/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AllNotesListViewController: UIViewController {

    private let myTableView = UITableView()
    var filesArray = [String]()
    var a=(UserDefaults.standard.string(forKey: "Name") ?? nil)!
    
    private let SubTitleLabel : UILabel = {
        let label = UILabel()
        //label.text = "Your All Notes"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.font = UIFont(name: "HoeflerText-BlackItalic", size: 20)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.shadowColor = .white
        return label
    }()
    
    private let LogoutButton : UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(OnLogoutClicked), for: .touchUpInside)
        button.backgroundColor = UIColor(cgColor: UIColor.black.cgColor)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        filesArray = FileManagerService.getFiles()
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg3")!)
        view.backgroundColor = .white
        view.addSubview(myTableView)
        setupTableView()
        view.addSubview(SubTitleLabel)
        view.addSubview(LogoutButton)
        SubTitleLabel.text = "Welcome \(a) ,Here Your All Notes"
        
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SeeNotes))
        navigationItem.setRightBarButton(addItem, animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
     myTableView.frame = CGRect(x: 0, y: 100, width:view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom-100)
    SubTitleLabel.frame = CGRect(x: 10, y: 50, width: view.frame.size.width, height: 70)
        
    LogoutButton.frame = CGRect(x: 70, y: 600, width: view.frame.size.width-150, height: 35)
    }

}

extension AllNotesListViewController :UITableViewDataSource,UITableViewDelegate {

    @objc func OnLogoutClicked()
    {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func setupTableView()
    {
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotesCell")
        let a = FileManagerService.getFiles();
        print("All Files in Controller : ", a)
    }

     @objc func SeeNotes()
     {
        let newNote = NotesViewController()
        navigationController?.pushViewController(newNote, animated: true)
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return filesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        let notes = filesArray[indexPath.row]
        cell.textLabel?.text = "\(notes)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let existNote = NotesViewController()
        existNote.Notes = filesArray[indexPath.row]
        navigationController?.pushViewController(existNote, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let vc = NotesViewController();
        vc.deleteNote(name: filesArray[indexPath.row])
        filesArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
}
