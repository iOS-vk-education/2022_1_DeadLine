//
//  FindViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 18.04.2022.
//

import UIKit




class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet var tableView: UITableView!
    let myData = ["first","second","third", "four", "five","first","second","third", "four", "five"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        if !UserDefaults().bool(forKey: "tasks"){
            UserDefaults().set(true, forKey: "tasks")
            UserDefaults().set(0, forKey: "count")
        }
    }
    

    //Table FN
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell",
                                                 for: indexPath) as! DemoTableViewCell
        cell.myLablel.text =  myData[indexPath.row]
        
        return cell
    }

}
