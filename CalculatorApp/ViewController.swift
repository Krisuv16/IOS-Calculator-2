/*
 File Name: ViewController
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100)
 Date: 2022-09-21
 Description: Creates the main UI of the calculator app and adds all the fuctionality for mathematical calculation
 Version: 1.0
 */

import UIKit

class ViewController: UIViewController {
    
    var leftOperand : Float = 0.0 /// Left Operands
    var rightOperand : Float = 0.0 /// Right Operands
    var result : Float = 0.0 /// for the last result of the operations
    var clickedOperator = "" /// Stores the operator that is clicked
    var activeOperator = "" /// Active Operator
    var resetLabel = true ///resets input label
    
    
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
    
    /// Determines the action to be performed on non-operator button pressing
    /// - Parameter sender: UIButton control that executes the custom code in response to user interaction
    @IBAction func onNonOperatorPressed(_ sender: UIButton) {
        
        switch sender.titleLabel!.text {
        case "Clear":
            clearValues() /// call clearValues function
        case ".":
          forDecimalPoint() /// calls forDecimalPoint function
        case "+/-":
            forPlusMinusOperator() // calls forPlusMinusOperator
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
    
    
    
    /// Determines the action to be performed on operator pressed
    /// - Parameter sender: UIButton control that executes the custom code in response to user interaction
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
        case "5":
            result = leftOperand / 100
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
    
    
    ///  Erases last item
    /// - Parameter sender:UIButton control that executes the custom code in response to user interaction
    @IBAction func forBackSpace(_ sender: UIButton) {
        if(!ResultLabel.text!.isEmpty){
            ResultLabel.text!.removeLast()
        }
    }
    
    
    /// Function deals with decimal point and helps to concatination of decimal
    func forDecimalPoint(){
        if(!ResultLabel.text!.contains("."))
        {
            ResultLabel.text! += "."
        }else if( !ResultLabel.text!.contains("0")){
            ResultLabel.text! += "0."
        }
    }
    
    /// Toggle negative and positive float or integer
    func forPlusMinusOperator(){
        if(ResultLabel.text! != "0"){
            if(!ResultLabel.text!.contains("-")){
                ResultLabel.text!.insert("-", at: ResultLabel.text!.startIndex)
            }else{
                ResultLabel!.text!.remove(at: ResultLabel.text!.startIndex)
            }
        }
    }
    
    /// Function that resets all the operation and values
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
