//
//  startViewController.swift
//  original
//
//  Created by heiwa on 2016/02/27.
//  Copyright © 2016年 heiwa. All rights reserved.
//

import UIKit
import FirebaseAuth

class startViewController: UIViewController {
    
    //    @IBOutlet var startButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkUserVerify()-> Bool {
        
        guard let user = FIRAuth.auth()?.currentUser else { return false }
        print(user.isEmailVerified)
        return user.isEmailVerified
    }
    
    
    @IBAction
    func toGameView(_ sender: Any) {
        
        if !checkUserVerify() {
            
            self.performSegue(withIdentifier: "toLoginView", sender: nil)
           
            
        }else{
            print("hoge")
            
            
            self.performSegue(withIdentifier: "toGame", sender: nil)
        }
    }
    
}
