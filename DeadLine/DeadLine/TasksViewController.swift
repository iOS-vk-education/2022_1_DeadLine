////
////  FindViewController.swift
////  DeadLine
////
////  Created by Roman Nizovtsev on 18.04.2022.
////
//
//import UIKit
//
//
//
//
//class TasksViewController: UITableViewController {
//
//
//
//    //@IBOutlet var tableView: UITableView! = .init(frame: .zero, style: .insetGrouped)
//    var tasks = ["first","second","third", "four", "five","first","second","third", "four", "five"]
//
////    var myTask = Task(Title: "Test", Description: "Test", Priority: 0.0)
////    //var Tasks: [Task] = ()
////    var tasks: [String] = []
////    var tasks: [String] = [] {
////        didSet {
////               // reload()
////                self.tableView.reloadSections(.init(integer: 0), with: .fade)
////            }
////
////    }
//   // var update: (() -> Void)?
////    update = {
////        DispatchQueue.main.async {
////            vc.updateTasks()
////        }
////    }
////    var update: (()->Void)?
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("ALL TASSKS", tasks.count, tasks)
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("ALL TASSKS", tasks.count, tasks)
//        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.allowsSelection = false
//
//        //self.Tasks.append(myTask)
//
//        //UserDefaults().set(0, forKey: "count")
////        UserDefaults().set(Tasks, forKey: "Tasks")
//
//        if !UserDefaults().bool(forKey: "setup"){
//            UserDefaults().set(true, forKey: "setup")
//            UserDefaults().set(0, forKey: "count")
//        }
////        let domain = Bundle.main.bundleIdentifier!
////        UserDefaults.standard.removePersistentDomain(forName: domain)
////        UserDefaults.standard.synchronize()
//        //print("My Tasks ===== ", Tasks.count)
//        //print(Tasks)
//
//        //updateTasks()
//
//
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    //Table FN
//    func update(){
//                DispatchQueue.main.async {
//                    self.updateTasks()
//                }
//    }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return myData.count
////    }
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let cnt =  UserDefaults().value(forKey: "count") as! Int
////        cnt = cnt - 1
//       // print("Return cnt ===== ", Tasks.count)
////        return cnt
//        return tasks.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("!!!!!!!!!!!!DRAW CELLS!!!!!!!!!!!!!!! ", indexPath.count)
//       // print(self.Tasks)
//        //updateTasks()
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell",
//                                                 for: indexPath) as! DemoTableViewCell
//
//
//        let count = UserDefaults().value(forKey: "count") as? Int
//        if count == 0 {
//            return cell
//        }
//
//
////        cell.myLablel.text =  myData[indexPath.row]
////        guard let count = UserDefaults().value(forKey: "count") as? Int else {
////            return
////        }
////
////        guard let Tasks = UserDefaults().value(forKey: "Tasks") as? [Task] else {
////            return
////        }
////        cell.myLablel.text =  myData[indexPath.row]
////        let Tasks = UserDefaults().value(forKey: "Tasks") as! [Task]
//        print(indexPath.row)
//        //cell.myLablel?.text =  Tasks[indexPath.row].Title
//        cell.myLablel?.text =  tasks[indexPath.row]
//
//        return cell
//    }
//    func updateTasks(){
//        tasks.removeAll()
//        guard let count = UserDefaults().value(forKey: "count") as? Int else {
//            return
//        }
//        for x in 0..<count{
//            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
//                tasks.append(task)
//            }
//        }
//        self.tableView.reloadData()
//        print(tasks)
//
//
//    }
//
//    func updateTasks(){
//        //self.Tasks = UserDefaults().value(forKey: "Tasks") as! [Task]
//
//        do {
//            let decoded  = UserDefaults.standard.object(forKey: "NewTask") as! Data
//            let decodedTeams = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! Task
//            //print(decodedTeams.name)
//            Tasks.append(decodedTeams)
//
//        }catch let error as NSError {
//            print(error.debugDescription)
//        }
//
//    }
//
//    func addTask(task: Task){
////        self.Tasks.append(task)
////        print(self.Tasks)
//        print("Append", task)
//        //self.Tasks.append(task)
//        //self.Tasks.append(task)
////        print(self.Tasks)
//
////        print(UserTaskCache.get())
//        //self.Tasks.append(UserTaskCache.get()!)
//        //print(self.Tasks)
////        let encodedData = NSKeyedArchiver.archivedData(withRootObject: task, requiringSecureCoding: false)
////        let userDefaults = UserDefaults.standard
////        userDefaults.set(encodedData, forKey: "Tasks")
//
//        //self.tableView.reloadData()
//        self.tableView.reloadSections(.init(integer: 0), with: .fade)
//
//    }
//
//    @IBOutlet weak var refreshbtn: UIButton!
//    @IBAction func reload(_ sender: UIButton){
//        print(self.tasks)
//        self.tableView.reloadSections(.init(integer: 0), with: .fade)
//    }
//
//}
//
//




import UIKit

class TasksViewController: UITableViewController {

    var tasks = ["first","second"]
   // var Tasks: [Task] = ()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        //Clean UserDefaults
        
//                let domain = Bundle.main.bundleIdentifier!
//                UserDefaults.standard.removePersistentDomain(forName: domain)
//                UserDefaults.standard.synchronize()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @IBOutlet weak var refreshbtn: UIButton!
        @IBAction func reload(_ sender: UIButton){
           // tasks.append("New Task")
            print("TASKS:", tasks)
            updateTasks()
            //self.tableView.reloadSections(.init(integer: 0), with: .fade)
        }
    
    
        func updateTasks(){
            print("Updata table")
            tasks.removeAll()
            guard let count = UserDefaults().value(forKey: "count") as? Int else {
                return
            }
            for x in 0..<count{
                if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{
                    tasks.append(task)
                }
            }
            //tasks.append("!!!!")
            print(tasks)
            tableView.reloadData()
    
    
        }
    
    

    // MARK: - Table view data source
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("ALL TASSKS", tasks.count, tasks)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! DemoTableViewCell

        
        cell.myLablel?.text =  tasks[indexPath.row]
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
