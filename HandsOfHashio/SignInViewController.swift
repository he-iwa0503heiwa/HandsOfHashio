//
//  SignInViewController.swift
//  HandsOfHashio
//
//  Created by heiwa on 2017/02/03.
//  Copyright © 2017年 heiwa. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
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
    
    @IBAction func signIn(_ sender: Any) {
        //EmailとPasswordのTextField1に文字がなければ、その後の処理をしない
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
        
        //let email = "heiwa.2012.nin@gmail.com"
        //let password = "testtest"
        
        print(email)
        
        
        if email != nil && password != nil{
            
            //signInWithEmail1でログイン
            //第一引数にEmail、第二引数にパスワードをとります
            FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: { (user, error) in
                //エラーが無いことを確認
                if error == nil {
                    if let longinUser = user {
                        //バリデーションが完了しているか確認。完了ならそのままログイン
                        if (user?.isEmailVerified)! {
                            //完了済みなら、ListViewControllerに遷移
                            print(FIRAuth.auth()?.currentUser)
                            self.performSegue(withIdentifier: "toView", sender: nil)
                            
                        }else{
                            
                        }
                        
                    }
                }else{
                    
                    print("error...\(error?.localizedDescription)")
                    
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
