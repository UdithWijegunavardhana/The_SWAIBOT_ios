//
//  signupViewController.swift
//  customlogin
//
//  Created by Udith Wijegunavardhana on 2021-09-04.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class signupViewController: UIViewController {

    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var errorLable: UILabel!
    
    
    @IBOutlet weak var topnavigationbar: UINavigationBar!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    func setUpElements(){
        
        errorLable.alpha = 0
        Utilities.styleTextField(firstnameTextField)
        Utilities.styleTextField(lastnameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signupButton)

    }
    
    func validateFields() -> String?{
        if firstnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "please fill all the fields"
        }
        
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(password) == false{
            return "password should be at least 8 characters, one simbol and upper and lower case letters"
        }
        
        return nil
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            
            errorShow(error!)
            
        }else{
            
            let firstname = firstnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error)in
                if error != nil{
                    self.errorShow("Error creating user")
                }else{
                    let db = Firestore.firestore()
                    db.collection("user").addDocument(data: ["firstname" : firstname , "lastname": lastname , "uid": result!.user.uid]) { (error) in
                        
                        if error != nil{
                            self.errorShow("user data cannot be saved")
                        }
                    }
                    
                    self.transitionToHome()
                    
                }
            }
            
            
            
        }
        
    }
    
    func errorShow (_ massage: String){
        errorLable.text = massage
        errorLable.alpha = 1
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? homeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    

}
