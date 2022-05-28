//
//  OtherViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 18.04.2022.
//

import UIKit
import Firebase

class OtherViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var btnDel: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        if (Auth.auth().currentUser == nil)
        {
            lblEmail.text = "Авторизируйтесь для начала работы с приложением"
            btnDel.isHidden = true
            btnAbout.isHidden = true
            btnOut.isHidden = true
            btnIn.isHidden = false
            btnRegister.isHidden = false
            
        }
        else
        {
            btnDel.isHidden = false
            btnAbout.isHidden = false
            btnOut.isHidden = false
            btnIn.isHidden = true
            btnRegister.isHidden = true
            let value = defaults.string(forKey: "user")
            lblEmail.text = value
        }
        
    }
    
    @IBAction func btnOutClicked(_ sender: Any) {
        try! Auth.auth().signOut()
        lblEmail.text = "Авторизируйтесь для начала работы с приложением"
        btnOut.isHidden = true
        btnIn.isHidden = false
        btnRegister.isHidden = false
        btnDel.isHidden = true
        btnAbout.isHidden = true

        
    }
    
    
 

}
