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
    var clickedOperator = "" // Operator that is clicked
    var presentOperator = "" // Operator that is currently in use
    var resetLabel = true
    
    
    @IBOutlet weak var ResultLabel: UILabel! // Result Label to display Numbers and results
    @IBOutlet var viewBorder: [UIView]! //Border
    @IBOutlet var calBtn: [UIButton]! //Calculator Button
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This part deals with the border uper and lower border, makes the width 1 and makes radius 32
        //every border present of a view will have a corner radius of 32
        for borders in viewBorder{
            borders.layer.borderWidth = 1
            borders.layer.cornerRadius = 32
        }
        //THis part deals with the button radius
        //every button will have radius of 20
        for btns in calBtn {
            btns.layer.cornerRadius = 20
        }
    }
    
    @IBAction func onNonOperatorPressed(_ sender: UIButton) {
        /*
         Switch Case function for Non Number Operator
         Clear clears the label and values
         forDecimal Handle Decimal exceptions
         forPlusMinusOperator Handles the + or -
         */
         
        switch sender.titleLabel!.text {
        case "Clear":
            clearValues()
        case ".":
          forDecimalPoint()
        case "+/-":
            forPlusMinusOperator()
        default:
            //If the first number is 0 then this will be executed
            if(ResultLabel.text! == "0" || resetLabel){
                ResultLabel.text = sender.titleLabel!.text!
                resetLabel = false
            }else{
                
                if(ResultLabel.text!.count > 12){}//This will restrict the character to only 12
                ResultLabel.text! += sender.titleLabel!.text!
            }
        }
    }
    
    
    @IBAction func onOperatorPressed(_ sender: UIButton) {
        
        // We used tag because image could not have title and it would be shown to the UI
        clickedOperator = String(sender.tag)
        
        if(presentOperator == ""){
            presentOperator = clickedOperator
            print(presentOperator)
            resetLabel = true;
        }
        
        if (result != 0.0){return}
        
        if(leftOperand != 0.0){
            rightOperand = Float(ResultLabel.text!)!
        }else{
            leftOperand = Float(ResultLabel.text!)!
        }
        
        if(rightOperand == 0.0 && clickedOperator != "10"){return}
        
        
        //Functional Code
        
        /*
         Tag 1 = +,
         Tag 2 = -,
         Tag 3 = X,
         Tag 4 = /,
         Tag 5 = %,
         Tag 10 = "="
         */
        
        switch presentOperator {
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
        
        //Resetting the values to the next operation
        
        leftOperand = result //setting the value of left operand to the result
        rightOperand = 0.0
        presentOperator = clickedOperator
        result = 0.0
        resetLabel = true
        
        ResultLabel.text! = "\(leftOperand)"  // COnverting FLoat Value to string
        
    }
    
    //Function that is responsible to remove last element
    @IBAction func forBackSpace(_ sender: UIButton) {
        if(!ResultLabel.text!.isEmpty){
            ResultLabel.text!.removeLast()
        }
    }
    
    
    //FUnction that deals with decimal point
    func forDecimalPoint(){
        //If the first character is . then it gets concatinated
        if(!ResultLabel.text!.contains("."))
        {
            ResultLabel.text! += "."
        }else if( !ResultLabel.text!.contains("0")){ //If the first character is 0 then it gets concatinated with 0.
            ResultLabel.text! += "0."
        }
    }
    
    //Function for Plus minus Operator
    func forPlusMinusOperator(){
        if(ResultLabel.text! != "0"){
            if(!ResultLabel.text!.contains("-")){
                ResultLabel.text!.insert("-", at: ResultLabel.text!.startIndex)
            }else{
                ResultLabel!.text!.remove(at: ResultLabel.text!.startIndex)
            }
        }
    }
    
    
    //Resets the Values
    func clearValues(){
         ResultLabel.text! = "0"
         leftOperand = 0.0
         rightOperand = 0.0
         result = 0.0
         clickedOperator = ""
         presentOperator = ""
         resetLabel = true
    }
    
}
