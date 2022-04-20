//
//  FavoritesViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 18.04.2022.
//

import UIKit



//struct Task:Codable{
//    var Title: String
//    var Description: String
//    var Priority:Double
//}

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
//        var Tasks = UserDefaults().value(forKey: "Tasks") as? [Task]
        
        
        let newCount = count + 1
        var newTask: Task
        newTask = getTask(tfTitle,tfDescription,sldrPriority)
        print("GOT TASK")
        print(newTask)

        //newTasks = Tasks!
//        Tasks.append(newTask)
        //newTasks.append(newTask)
        


        UserDefaults().set(newCount, forKey: "count")
        print("set count", newCount)
//        UserDefaults().set(Tasks, forKey: "Tasks")

        //print(Tasks)
        //let vc = storyboard?.instantiateViewController(withIdentifier: "tasks_vc") as! TasksViewController
        print("HERE")
        //vc.addTask(task:newTask)
        //UserTaskCache.save(newTask)
        
//        do {
//            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: newTask, requiringSecureCoding: false)
//            let userDefaults = UserDefaults.standard
//            userDefaults.set(encodedData, forKey: "NewTask")
//        }catch let error as NSError {
//            print(error.debugDescription)
//        }
//
//        print("go to tasks")
        saveTask()
//        DispatchQueue.main.async {
//            vc.updateTasks()
//        }
//        vc.update{
//            DispatchQueue.main.async {
////                vc.updateTasks()
//                fn()
//            }
//        }
//        vc.update = {
//            DispatchQueue.main.async {
//                vc.updateTasks()
//            }
//        }
//        update?()

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

//        if let cell =  vc.tableView.cellForRow(at: newCount) as? UITableViewCell{
//            cell.textLabel.text = text
//        }
        
    }
    
    


}
