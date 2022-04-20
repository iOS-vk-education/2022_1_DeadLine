//
//  FavoritesViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 18.04.2022.
//

import UIKit




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

struct Task: Codable {
    var Title: String
    var Description: String
    var Priority:Double
}

func getTask(_ title: UITextField,_ description: UITextField,_ priority: UISlider) -> Task{
    var gotTask = Task(Title: "error", Description: "error", Priority: 0.0)
    guard let gotTitle = title.text, !gotTitle.isEmpty else { return gotTask}
    guard let gotDescription = description.text, !gotDescription.isEmpty else { return gotTask}
    let gotPriority = priority.value
    
    gotTask.Title = gotTitle
    gotTask.Description = gotDescription
    gotTask.Priority = Double(gotPriority)
    return gotTask
}



class AddViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfDescription: UITextField!
    @IBOutlet var sldrPriority: UISlider!
    @IBOutlet var btnAdd: UIButton!
    


    @IBAction func addTask(_ sender: UIButton){
        print("ADDDDDD")
//        var newTasks: [Task]
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            print("error")
            return
        }
        
        let newCount = count + 1
        var newTask: Task
        newTask = getTask(tfTitle,tfDescription,sldrPriority)


        UserDefaults().set(newCount, forKey: "count")
        saveTask()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tfTitle.delegate = self
        
        
    }
    var index = IndexPath()
    
    @objc func saveTask(){
        guard let text = tfTitle.text, !text.isEmpty else {
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        print("set count", newCount)
        UserDefaults.standard.synchronize()
        

        let vc = storyboard?.instantiateViewController(withIdentifier: "tasks_vc") as! TasksViewController

        //vc.tasks.append("KEKICH")
        print(vc.tasks)
        vc.updateTasks()

        
    }
    
    


}
