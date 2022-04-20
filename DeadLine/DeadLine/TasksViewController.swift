////
////  FindViewController.swift
////  DeadLine
////
////  Created by Roman Nizovtsev on 18.04.2022.
////

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

}
