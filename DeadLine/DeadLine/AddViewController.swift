//
//  FavoritesViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 18.04.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

struct UserTaskCache {
    static let key = "userProfileCache"
    static func save(_ value: Task!) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }
    static func get() -> Task! {
        var userData: Task!
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userData = try? PropertyListDecoder().decode(Task.self, from: data)
            return userData!
        } else {
            return userData
        }
    }
    static func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

func getTask(_ title: UITextField,_ description: UITextField,_ priority: UISlider) -> Task{
    var gotTask = Task(Title: "error", Description: "error", Priority: 0.0, Done: false)
    guard let gotTitle = title.text, !gotTitle.isEmpty else { return gotTask}
    guard let gotDescription = description.text, !gotDescription.isEmpty else { return gotTask}
    let gotPriority = priority.value
    
    gotTask.Title = gotTitle
    gotTask.Description = gotDescription
    gotTask.Priority = Float(gotPriority)
    return gotTask
}

class AddViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDescription: UITextField!
    @IBOutlet var sldrPriority: UISlider!
    @IBOutlet var btnAdd: UIButton!
    private let encoder = JSONEncoder()
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
        if (Auth.auth().currentUser == nil)
        {
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present alert to user
            self.present(dialogMessage, animated: true, completion: nil)
        }else{
            Firebase()
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
    }
    
    func Firebase(){
        guard let databasePath = databasePath else {
          return
        }
        let task = Task(Title: tfTitle.text ?? "-",Description: tfDescription.text ?? "-",Priority: sldrPriority.value, Done: false)
        do {
          let data = try encoder.encode(task)
          let json = try JSONSerialization.jsonObject(with: data)
            databasePath.child(task.Title)
            .setValue(json)
        } catch {
          print("an error occurred", error)
        }
    }
}
