//
//  ViewController.swift
//  calculator-ios
//
//  Created by huang tsun yu on 2016/3/19.
//  Copyright © 2016年 Train. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var numPad: UILabel!
    
    var operaNum: Int = 0
    var total: Double = 0.0
    var dot: Bool = false
    var zero_neg: Bool = false
    
    @IBAction func addNumber(sender: UIButton) {
        func append(digit: Int) {
            
            if let text = numPad.text where Double(text)! != 0.0 {
                numPad.text = text + "\(digit)"
            } else {
                numPad.text = (digit as NSNumber).stringValue
            }
        }
        
        
        guard !dot else{
            if operaNum == 5 {
                operaNum = 0
            }
            numPad.text! = "\(numPad.text!)\(sender.tag)"
            return
            
        }
        
        guard operaNum != 5 else{
                
            numPad.text = (sender.tag as NSNumber).stringValue
            operaNum = 0
            return
        }
        
        
        guard !zero_neg else{
            
            numPad.text! = "-\(sender.tag)"
            zero_neg = false
            return
                
        }
        
        
        if sender.tag >= 0 && sender.tag < 10 {
            append(sender.tag)
        }

        
    }
    

    @IBAction func clickOperator(sender: UIButton) {
        
        let operator_text: String = sender.titleLabel!.text!
        
        guard var num_pad_text = numPad.text else{
            print("NoNumberError")
            return
        }
        
        guard var num_pad_number = Double(num_pad_text) else{
            print("NotDoubleError")
            return
        }

        func clear(){
            numPad.text = "0"
        }
        
        func calculate(number:Double){
            
            dot = false
            
            switch operaNum{
            case 0:
                total = number
            case 1:
                total = total+number
            case 2:
                total = total-number
            case 3:
                total = total*number
            case 4:
                total = total/number
            default:
                clear()
            }
        }
        

        switch operator_text {
        case "AC":
            clear()
            operaNum = 0
            total = 0.0
            dot = false
            zero_neg = false
        case "C":
            numPad.text = String(num_pad_text.characters.dropLast())
        case "+":
            calculate(num_pad_number)
            operaNum = 1
            clear()
        case "-":
            
            guard num_pad_number != 0.0 else {
                //0+(-3),the minus number will appear because the nag,if operaNum = 2,then 0-(-3) is wrong
                operaNum = 1
                zero_neg = true
                return
            }
            
            calculate(num_pad_number)
            operaNum = 2
            clear()

        case "×":
            calculate(num_pad_number)
            operaNum = 3
            clear()
        case "÷":
            calculate(num_pad_number)
            operaNum = 4
            clear()
        case "=":
            calculate(num_pad_number)
            operaNum = 5
            var total_string = "\(total)"
            guard total_string.hasSuffix(".0") == false else{
                let range = total_string.endIndex.advancedBy(-2)..<total_string.endIndex
                total_string.removeRange(range)
                numPad.text = total_string
                return
            }
            
            numPad.text = "\(total)"
        case "+/-":
            //if no - ,add -;if has -,remove -
            if num_pad_text.rangeOfString("-") == nil {
                
                num_pad_text = "-\(num_pad_text)"
            }else{
                num_pad_text = String(num_pad_text.characters.dropFirst())
            }
            numPad.text = num_pad_text
        case "%":
            num_pad_number = num_pad_number/100
            numPad.text = "\(num_pad_number)"
        case ".":
            //if no dot,add the dot
            if num_pad_text.rangeOfString(".") == nil {
                num_pad_text = "\(num_pad_text)."
                dot = true
            }
            
            numPad.text = num_pad_text
        
        default:
            print("error")
        }
        
    }
    
    
}

