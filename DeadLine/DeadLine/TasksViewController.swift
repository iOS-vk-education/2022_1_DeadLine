////
////  TasksViewController.swift
////  DeadLine
////
////  Created by Roman Nizovtsev on 18.04.2022.
////

import UIKit
import FirebaseAuth
import FirebaseDatabase
class TasksViewController: UITableViewController {
    @IBOutlet weak var addBtn: UIButton!
    var Tasks: [Task] = []
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
    
    @IBAction func onClickDeleteButton1(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexpath = tableView.indexPathForRow(at: point) else {return}
        let reference = databasePath?.ref.child(Tasks[indexpath.row].Title)
        reference?.removeValue { error, _ in
                     print(error?.localizedDescription ?? "error")
                 }
        Tasks.remove(at: indexpath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
        tableView.endUpdates()
       
    }

    @IBAction func radioSelected(_ sender: UIButton) {
        sender.isSelected = true
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexpath = tableView.indexPathForRow(at: point) else {return}
        let reference = databasePath?.ref.child(Tasks[indexpath.row].Title)
        if(Tasks[indexpath.row].Done == false)
        {
        Tasks[indexpath.row].Done = true
            do {
              let data = try encoder.encode(Tasks[indexpath.row])
              let json = try JSONSerialization.jsonObject(with: data)
                reference?
                .setValue(json)
            } catch {
              print("an error occurred", error)
            }
        Tasks.remove(at: indexpath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
        tableView.endUpdates()
        }
    }
   
    @IBAction func celSelected(_ sender: UIButton){
        print("click")
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexpath = tableView.indexPathForRow(at: point) else {return}
        let param = Tasks[indexpath.row].Title
        let vc = storyboard?.instantiateViewController(withIdentifier: "taskDetails_vc") as! TaskDetailsViewController
        vc.task = param
        navigationController?.pushViewController(vc, animated: true)
    }

    private let decoder = JSONDecoder()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.Tasks.removeAll()
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        loadFirebase()
    }
    
    // MARK: - Table view data source
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Tasks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! DemoTableViewCell
        if(Tasks.count>0)
        {
        cell.myLablel?.text =  Tasks[indexPath.row].Title
        }
        return cell
    }
    
    func loadFirebase()
    {
        let databasePath: DatabaseReference? = {
      guard let uid = Auth.auth().currentUser?.uid else {
        return nil
      }
      let ref = Database.database()
        .reference()
        .child("users/\(uid)/tasks")
      return ref
    }()
        guard let databasePath = databasePath else {
          return
        }
        databasePath
          .observe(.childAdded) { [weak self] snapshot in
            guard
              let self = self,
              let json = snapshot.value as? [String: Any]
            else {
              return
            }
            do {
              let taskData = try JSONSerialization.data(withJSONObject: json)
              let task = try self.decoder.decode(Task.self, from: taskData)
                if(task.Done == false){
                    self.Tasks.append(task)
                }
            } catch {
              print("an error occurred", error)
            }
              self.tableView.reloadData()
          }
        self.tableView.reloadData()
    }
}
