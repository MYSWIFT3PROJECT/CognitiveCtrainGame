//
//  MainViewController.swift
//  CognitiveCtrainGame
//
//  Created by ios Developer on 2/9/17.
//  Copyright © 2017 ios Developer. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var numberLabel:UILabel?
    @IBOutlet weak var scoreLabel:UILabel?
    @IBOutlet weak var inputField:UITextField?
    var score:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setRandomNumberLabel()
        updateScore()
        inputField?.addTarget(self, action: #selector(textFieldDiChange(textField:)), for: UIControlEvents.editingChanged)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func updateScore(){
        scoreLabel?.text = "\(#imageLiteral(resourceName: "score"))"
    }
    func setRandomNumberLabel() {
        numberLabel?.text = generatedRandomString()
    }
    func textFieldDiChange(textField:UITextField) {
        if inputField?.text?.characters.count ?? 0 < 4{
            return
        }
        if let number_text = numberLabel?.text,let input_text = inputField?.text, let numbers = Int(number_text),let input = Int(input_text)){
            print("Comparing:\(#imageLiteral(resourceName: "input")_text) minus \(number_text) == \(#imageLiteral(resourceName: "input")-numbers)")
            if(input - numbers == 1111){
                print("Correct!")
                score += 1
            }else{
                print("Incorrect!")
                score -= 1
            }
        }
        setRandomNumberLabel()
        updateScore()
    }
    func generatedRandomString() -> String {
        var result:String = ""
        for _ in 1...4{
            var digit:Int = Int(arc4random_uniform(8)+1)
            result += "\(digit)"
        }
        return result
    }
}
