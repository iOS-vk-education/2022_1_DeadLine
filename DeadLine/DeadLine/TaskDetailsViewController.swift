//
//  TaskDetailsViewController.swift
//  DeadLine
//
//  Created by Андрей Кравцов on 29.05.2022.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class TaskDetailsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDescription: UITextField!
    @IBOutlet var sldrPriority: UISlider!
    @IBOutlet var btnAdd: UIButton!
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    var task = ""
    var index = IndexPath()
    
    private lazy var databasePath: DatabaseReference? = {
      guard let uid = Auth.auth().currentUser?.uid else {
        return nil
      }
      let ref = Database.database()
        .reference()
        .child("users/\(uid)/tasks")
      return ref
    }()

    @IBAction func addTask(_ sender: Any){
        // Create a new alert
        let dialogMessage = UIAlertController(title: "Ошибка", message: "Авторизируйтесь, чтобы добавить задачу", preferredStyle: .alert)
        let dialogMessage1 = UIAlertController(title: "Успешно", message: "Задача успешно добавлена", preferredStyle: .alert)
        if (Auth.auth().currentUser == nil){
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             })
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present alert to user
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            Firebase_update()
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                // close add task view
                self.navigationController?.popViewController(animated: true)
             })
            //Add OK button to a dialog message
            dialogMessage1.addAction(ok)
            // Present alert to user
            self.present(dialogMessage1, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tfTitle.delegate = self
        loadFirebase()
    }

    func Firebase_update(){
        guard let databasePath = databasePath else {
          return
        }
        let task = Task(Title: tfTitle.text ?? "-",Description: tfDescription.text ?? "-",Priority: sldrPriority.value, Done: false)
        do {
          let data = try encoder.encode(task)
          let json = try JSONSerialization.jsonObject(with: data)
            if (self.task ==  tfTitle.text){
                databasePath.child(self.task)
                    .updateChildValues(json as! [AnyHashable : Any])
            }else{
                databasePath.child(self.task).removeValue { error, _ in
                    print(error?.localizedDescription ?? "error")
                         }
                databasePath.child(task.Title)
                .setValue(json)
            }
        } catch {
          print("an error occurred", error)
        }
    }
    
    func Firebase(){
        guard let databasePath = databasePath else {
          return
        }
        let task = Task(Title: tfTitle.text ?? "-",Description: tfDescription.text ?? "-",Priority: sldrPriority.value, Done: false)

        do {
          let data = try encoder.encode(task)
          let json = try JSONSerialization.jsonObject(with: data)
          databasePath.childByAutoId()
            .setValue(json)
           
        } catch {
          print("an error occurred", error)
        }
    }
    
    func loadFirebase()
    {
        guard let databasePath = databasePath else {
          return
        }
        databasePath.child(self.task).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            self.tfTitle.text = value?["Title"] as? String ?? ""
            self.tfDescription.text = value?["Description"] as? String ?? ""
            }) { error in
              print(error.localizedDescription)
            }
    }
}
