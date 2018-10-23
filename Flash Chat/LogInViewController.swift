//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        SVProgressHUD.show()
        
        //TODO: Log in the user
        if (emailTextfield.text?.isEmpty)! && (passwordTextfield.text?.isEmpty)! {
            
            self.popUp(error: "No Email and Password")
            
        } else {
            
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                if error != nil {
                    
                    if AuthErrorCode(rawValue: error!._code) == .wrongPassword {
                        
                        self.popUp(error: "Wrong Password")
                        
                    }
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                    print("Successful log in")
                    self.performSegue(withIdentifier: "goToChat", sender: self)
                    
                    
                    
                }
                
            }
            
            
        }
       
        
    }
    
    func popUp(error: String) {
        
        
        
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
        
    }

    
    
}  
