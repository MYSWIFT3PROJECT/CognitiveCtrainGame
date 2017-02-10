//
//  MainViewController.swift
//  CognitiveCtrainGame
//
//  Created by ios Developer on 2/9/17.
//  Copyright © 2017 ios Developer. All rights reserved.
//

import UIKit
import MBProgressHUD
class MainViewController: UIViewController {
    
    
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var timeLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    var score:Int = 0
    
    var hub:MBProgressHUD?
    
    var timer:Timer!
    var seconds:Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hub = MBProgressHUD(view:self.view)
        if hub != nil{
            self.view.addSubview(hub!)
        }
        setRandomNumberLabel()
        updateScoreLabel()
        inputField?.addTarget(self, action: #selector(textFieldDiChange(textField:)), for: UIControlEvents.editingChanged)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func showHuD(isRight:Bool){
        var imageView:UIImageView?
        if isRight{
            imageView = UIImageView(image:UIImage(named:"thumbs-up"))
        }else{
            imageView = UIImageView(image:UIImage(named:"thumbs-down" ))
        }
        if(imageView != nil){
            hub?.mode = MBProgressHUDMode.customView
            hub?.customView = imageView
            hub?.show(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                self.hub?.hide(animated: true)
                self.inputField?.text = ""
            }
        
        }
    }
    func updateScoreLabel(){
        scoreLabel?.text = "\(score)"
    }
    func setRandomNumberLabel() {
        numberLabel?.text = generatedRandomNumber()
    }
  
    func textFieldDiChange(textField:UITextField) {
        if inputField?.text?.characters.count ?? 0 < 4{
            return
        }
        if let number_text = numberLabel?.text,
            let input_text = inputField?.text,
            let numbers = Int(number_text),
            let input = Int(input_text){
            print("Comparing:\(input_text) minus \(number_text) == \(input - numbers)")
            if(input - numbers == 1111){
                print("Correct!")
                showHuD(isRight: true)
                score += 1
            }else{
                print("Incorrect!")
                showHuD(isRight: false)
                score -= 1
            }
        }
       setRandomNumberLabel()
        updateScoreLabel()
        if(timer == nil){
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onUpdateTimer), userInfo: nil, repeats: true)
        }
    }
    func onUpdateTimer() -> Void {
        if (seconds > 0 && seconds <= 60){
            seconds -= 1
            updateTimeLabel()
        }else if(seconds == 0){
            if (timer != nil){
                timer!.invalidate()
                timer = nil
                let alertController = UIAlertController(title: "Time up!", message: "Your time is up! You got a score of :\(score)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "", style: .default, handler: nil)
                alertController.addAction(alertAction)
                score = 0
                seconds = 0
                updateTimeLabel()
                updateScoreLabel()
                setRandomNumberLabel()
            }
        }
    }
    func updateTimeLabel() {
        if(timeLabel != nil){
            let min:Int = (seconds / 60) % 60
            let sec:Int = (seconds % 60)
            let min_p:String = String(format: "%02d", min)
            let sec_p:String = String(format: "%02d", sec)
            timeLabel?.text = "\(min_p):\(sec_p)"
        }
    }
    func generatedRandomNumber() -> String {
        var result:String = ""
        for _ in 1...4{
            var digit:Int = Int(arc4random_uniform(8)+1)
            result += "\(digit)"
        }
        return result
    }
}
