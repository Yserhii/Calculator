//
//  ViewController.swift
//  ex02
//
//  Created by Yolankyi SERHII on 6/24/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResLabel: UILabel!
    
    var stillTyping = false
    var dotInPlace = false
    var zeroFlag = 0
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    var currenInput: Double {
        get {
            return Double(displayResLabel.text!)!
        } set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            
            if (valueArray.count > 1 && valueArray[1] == "0") {
                displayResLabel.text = "\(valueArray[0])"
            } else {
                displayResLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
       
        let number = sender.currentTitle!
        
        if (number == "0") {
            zeroFlag = 1
        }
        if (stillTyping && displayResLabel.text != "-0" && displayResLabel.text != "0"
            && displayResLabel.text != "-0.0" && displayResLabel.text != "0.0") {
            if ((displayResLabel.text?.count)! < 18) {
                displayResLabel.text = displayResLabel.text! + number
            }
        } else {
            displayResLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currenInput
        stillTyping = false
        dotInPlace = false
    }
    
    func operateWithTwoOperands(operation: (Double,Double) -> Double) {
        currenInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        if stillTyping && (firstOperand != 0 || zeroFlag == 1) {
            secondOperand = currenInput
        }
        dotInPlace = false
        switch operationSign {
            case "+":
                operateWithTwoOperands{$0 + $1}
            case "-":
                operateWithTwoOperands{$0 - $1}
            case "×":
                operateWithTwoOperands{$0 * $1}
            case "÷":
                operateWithTwoOperands{$0 / $1}
            default:
                break
        }
        if (sender.currentTitle! == "=") {
            firstOperand = 0
            secondOperand = 0
            stillTyping = false
            operationSign = ""
        }
    }
    
    @IBAction func ClearButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        zeroFlag = 0
        firstOperand = 0
        secondOperand = 0
        currenInput = 0
        stillTyping = false
        dotInPlace = false
        operationSign = ""
        displayResLabel.text = "0"
    }

    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        currenInput = -currenInput
        stillTyping = true
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        if (firstOperand == 0) {
            currenInput = currenInput / 100
        } else {
            secondOperand = firstOperand * currenInput / 100
        }
    }
    
    @IBAction func squreRootButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        currenInput = sqrt(currenInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        print(sender.currentTitle!)
        if (stillTyping && !dotInPlace) {
            displayResLabel.text = displayResLabel.text! + "."
            dotInPlace = true
        } else if (!stillTyping && !dotInPlace) {
            displayResLabel.text = "0."
        }
    }
}
