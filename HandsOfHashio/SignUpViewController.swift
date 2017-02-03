//
//  SignUpViewController.swift
//  HandsOfHashio
//
//  Created by heiwa on 2017/02/03.
//  Copyright © 2017年 heiwa. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signUp(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
        if email != nil && password != nil {
            //FiRAuth.auth()?.createUserWithEmailでサインアップ
            //第一引数にEmail、第二引数にパスワード
            FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion:{(user,error) in
                //エラーなしなら、認証完了
                if error == nil{
                    user?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            self.performSegue(withIdentifier: "toSignIn", sender: nil)
                            
                            
                            
                        }else {
                            print("\(error?.localizedDescription)")
                        }
                    })
                }else{
                    print("\(error?.localizedDescription)")
                }
                
            })
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
