//
//  SignInViewController.swift
//  DeadLine
//
//  Created by Roman Nizovtsev on 19.04.2022.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {
    @IBOutlet weak var login_text: UITextField!
    
    @IBOutlet weak var sign_in_btn: UIButton!
    @IBOutlet weak var pass1_text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignInClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: login_text.text!, password: pass1_text.text!) { (user, error) in
           if error == nil{
               self.navigationController?.popViewController(animated: true)
                          }
            else{
             let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
                 }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
