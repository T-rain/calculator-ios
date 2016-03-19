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
    
    var opera_num : Int = 0
    var total :Double = 0.0
    var dot : Bool = false
    var neg : Bool = false
    
    @IBAction func addNumber(sender: UIButton) {
        func append(digit: Int) {
            
            if let text = numPad.text where Double(text) != 0.0 {
                numPad.text = text + "\(digit)"
            } else {
                numPad.text = (digit as NSNumber).stringValue
            }
        }
        
        if(opera_num == 5){
            numPad.text = (sender.tag as NSNumber).stringValue
            opera_num = 0
            
        }else{
            if(dot){
                
                numPad.text! = "\(numPad.text!)\(sender.tag)"
                dot = false
            }else if(neg){
                numPad.text! = "-\(sender.tag)"
                neg = false
            }else{
                if(sender.tag >= 0 && sender.tag < 10){
                    append(sender.tag)
                }
            }

            
        }

        
    }
    

    @IBAction func clickOperator(sender: UIButton) {
        //判斷是哪個運算子
        let operator_text :String = sender.titleLabel!.text!
        
        //單純讓字面歸零
        func clear(){
            numPad.text = "0.0"
        }
        
        //計算之前的結果
        func calculate(number:Double){
            print(total)
            switch opera_num{
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
        
        
        guard var num_pad_text = numPad.text else{
            print("NoNumberError")
            return
        }
        
        guard var num_pad_number = Double(num_pad_text) else{
            print("NotDoubleError")
            return
        }
    
        switch operator_text {
        case "AC":
            clear()
            opera_num = 0
            total = 0.0
            dot = false
            neg = false
        case "C":
            clear()
        case "+":
            calculate(num_pad_number)
            opera_num = 1
            clear()
        case "-":
            if(num_pad_number == 0.0){
                neg = true
            }
            calculate(num_pad_number)
            opera_num = 2
            clear()
        case "×":
            calculate(num_pad_number)
            opera_num = 3
            clear()
        case "÷":
            calculate(num_pad_number)
            opera_num = 4
            clear()
        case "=":
            calculate(num_pad_number)
            opera_num = 5
            numPad.text = "\(total)"
        case "+/-":
            if(num_pad_text.rangeOfString("-") == nil){
                
                num_pad_text = "-\(num_pad_text)"
            }else{
                num_pad_text = String(num_pad_text.characters.dropFirst())
            }
            numPad.text = num_pad_text
        case "%":
            num_pad_number = num_pad_number/100
            numPad.text = "\(num_pad_number)"
        case ".":
            if(num_pad_text.rangeOfString(".") == nil){
                num_pad_text = "\(num_pad_text)."
            }
            dot = true
            numPad.text = num_pad_text
        
        default:
            print("error")
        }
        
    }
    
    
}

