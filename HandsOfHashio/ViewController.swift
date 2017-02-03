//
//  ViewController.swift
//  original
//
//  Created by heiwa on 2015/12/24.
//  Copyright © 2015年 heiwa. All rights reserved.
//

import UIKit
import CoreMotion

// test

class ViewController: UIViewController {
    
    @IBOutlet var label:UILabel!
    @IBOutlet var label2:UILabel!
    @IBOutlet var label3:UILabel!
    @IBOutlet var timerLabel:UILabel!
    @IBOutlet weak var label10: UILabel!
    
    var myNumber :Float = 1000
    var count: Float = 10.0
    var timer: Timer = Timer()
    let manager = CMMotionManager()
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        UIView.animate(withDuration: 1.0, delay: 0.0,
                       options: UIViewAnimationOptions.repeat, animations: { () -> Void in
                        self.label10.alpha = 0.0
        }, completion: nil)
        
        
        
        //取得の間隔
        
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.01,
                                         target: self,
                                         selector: #selector(ViewController.up),
                                         userInfo: nil,
                                         repeats: true)
        }
        
        manager.accelerometerUpdateInterval = 0.1
        
        
        
        if (manager.isAccelerometerActive) {
            manager.stopAccelerometerUpdates()
        }
        
        
        
        //取得開始
        manager.startAccelerometerUpdates(
            to: OperationQueue.current!,
            withHandler: {(data: CMAccelerometerData?, error: Error?) in
                //= {(data:CMAccelerometerData?, error:NSError?) -> Void in
                //            print(data!.acceleration.x)
                //            print(data!.acceleration.y)
                //            print(data!.acceleration.z)
                //            print("x:\(data!.acceleration.x) y:\(data!.acceleration.y) z:\(data!.acceleration.z)")
                //            print("x:\(data!.acceleration.x) y:\(data!.acceleration.y)")
                //            NSLog("X:%.2f Y:%.2f",data!.acceleration.x, data!.acceleration.y)
                
                let zetaitiX:Float = abs(Float (data!.acceleration.x))
                let zetaitiy:Float = abs(Float (data!.acceleration.y))
                
                self.label.text = String(format: "%.2f", zetaitiX)
                self.label2.text = String(format: "%.2f", zetaitiy)
                
                
                //            self.number = self.number - Int (zetaitiX)
                //            self.number = self.number - Int (zetaitiy)
                //
                self.myNumber = self.myNumber - (zetaitiX + zetaitiy) * 15
                //print(self.myNumber)
                
                
                if self.myNumber < 0{
                    self.label3.text = String("ゲームオーバー")
                } else {
                    self.label3.text = String(self.myNumber)
                }
                
                
        })
            // Do any additional setup after loading the view, typically from a nib.
        label3.text = String(myNumber)
    }
    
    
    func up() {
        timerLabel.text = String(format: "%.2f", count)
        if count <= 0.00{
            timerLabel.text = "0.00"
            timer.invalidate()
            
            let highScore1: Float = defaults.float(forKey: "score1")
            let highScore2: Float = defaults.float(forKey: "score2")
            let highScore3: Float = defaults.float(forKey: "score3")
            
            if myNumber > highScore1 {
                defaults.set(myNumber, forKey: "score1")
                defaults.set(highScore1, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
            }else if myNumber > highScore2{
                defaults.set(myNumber, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
                
            }else if myNumber > highScore3{
                defaults.set(myNumber, forKey: "score3")
                
            }
            
            if (manager.isAccelerometerActive) {
                
                manager.stopAccelerometerUpdates()
                //                var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
                //                appDelegate.message = "message" //appDelegateの変数を操作
                
                print(highScore1)
                print(highScore2)
                print(highScore3)
                performSegue(withIdentifier: "result", sender: nil)
                
            }
            
            
            
        }
        count = count - 0.01
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let resultViewController: ResultViewController = segue.destination
            as! ResultViewController
        
        resultViewController.myNumber = self.myNumber
    }
    
    
}


