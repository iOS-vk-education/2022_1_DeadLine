//
//  FavoritesViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 18.04.2022.
//

import UIKit

struct Task{
    var Title = "Название"
    var Description = "Описание"
    var Priority = 50
}

class AddViewController: UIViewController {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var btnAdd: UIButton!

    @IBAction func addTask(_ sender: UIButton){
        //self.btnAdd.isSelected = !self.myOption.isSelected
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    


}
