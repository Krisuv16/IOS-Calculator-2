/*
 File Name: ViewController
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100)
 Date: 2022-09-21
 Description: Creates the main UI for the Calculator App
 Version: 1.0
 */

import UIKit

class ViewController: UIViewController {
    
    var leftOperand : Float = 0.0 //for left operation
    var rightOperand : Float = 0.0 //for right operation
    var result : Float = 0.0 //for the last result of the operations
    var clickedOperator = ""
    var activeOperator = ""
    var resetLabel = true
    
    
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet var viewBorder: [UIView]!
    @IBOutlet var calBtn: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for borders in viewBorder{
            borders.layer.borderWidth = 1
            borders.layer.cornerRadius = 32
        }
        for btns in calBtn {
            btns.layer.cornerRadius = 20
        }
    }
    
    @IBAction func onNonOperatorPressed(_ sender: UIButton) {
        
        switch sender.titleLabel!.text {
        case "Clear":
            clearValues()
        case ".":
          forDecimalPoint()
        case "+/-":
            forPlusMinusOperator()
        default:
            if(ResultLabel.text! == "0" || resetLabel){
                ResultLabel.text = sender.titleLabel!.text!
                resetLabel = false
            }else{
                if(ResultLabel.text!.count > 15){}
                ResultLabel.text! += sender.titleLabel!.text!
            }
        }
    }
    
    
    @IBAction func onOperatorPressed(_ sender: UIButton) {
        
        clickedOperator = String(sender.tag)
        
        if(activeOperator == ""){
            activeOperator = clickedOperator
            print(activeOperator)
            resetLabel = true;
        }
        
        if (result != 0.0){return}
        
        if(leftOperand != 0.0){
            rightOperand = Float(ResultLabel.text!)!
        }else{
            leftOperand = Float(ResultLabel.text!)!
        }
        
        if(rightOperand == 0.0 && clickedOperator != "10"){return}
        
        switch activeOperator {
        case "1":
            result = leftOperand + rightOperand
        case "2":
            result = leftOperand - rightOperand
        case "3":
            result = leftOperand * rightOperand
        case "4":
            result = leftOperand / rightOperand
        case "10":
            result = leftOperand
        default:
            print("")
        }
        
        
        leftOperand = result
        rightOperand = 0.0
        activeOperator = clickedOperator
        result = 0.0
        resetLabel = true
        
        ResultLabel.text! = "\(leftOperand)"
        
    }
    
    
    @IBAction func forBackSpace(_ sender: UIButton) {
        if(!ResultLabel.text!.isEmpty){
            ResultLabel.text!.removeLast()
        }
    }
    
    
    func forDecimalPoint(){
        if(!ResultLabel.text!.contains("."))
        {
            ResultLabel.text! += "."
        }else if( !ResultLabel.text!.contains("0")){
            ResultLabel.text! += "0."
        }
    }
    
    func forPlusMinusOperator(){
        if(ResultLabel.text! != "0"){
            if(!ResultLabel.text!.contains("-")){
                ResultLabel.text!.insert("-", at: ResultLabel.text!.startIndex)
            }else{
                ResultLabel!.text!.remove(at: ResultLabel.text!.startIndex)
            }
        }
    }
    
    func clearValues(){
        ResultLabel.text! = "0"
         leftOperand = 0.0 //for left operation
         rightOperand = 0.0 //for right operation
         result = 0.0 //for the last result of the operations
         clickedOperator = ""
         activeOperator = ""
        resetLabel = true
    }
    
}
