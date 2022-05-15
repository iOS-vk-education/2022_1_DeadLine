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
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnIn: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Auth.auth().currentUser == nil)
        {
            lblText.text = "Вы не авторизированы"
            lblEmail.isHidden = true
            btnOut.isHidden = true
            btnIn.isHidden = false
            btnRegister.isHidden = false
            
        }
        else
        {
            lblText.text = "Вы авторизированы"
            lblEmail.isHidden = false
            btnOut.isHidden = false
            btnIn.isHidden = true
            btnRegister.isHidden = true
            let value = defaults.string(forKey: "user")
            lblEmail.text = value
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOutClicked(_ sender: Any) {
        try! Auth.auth().signOut()
        lblText.text = "Вы не авторизированы"
        lblEmail.isHidden = true
        btnOut.isHidden = true
        btnIn.isHidden = false
        btnRegister.isHidden = false
        
    }
    
    
 

}
