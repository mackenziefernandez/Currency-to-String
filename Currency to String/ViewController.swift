//
//  ViewController.swift
//  Currency to String
//
//  Created by Mackenzie Fernandez on 7/29/15.
//  Copyright (c) 2015 Mackenzie Fernandez. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currencyTextField.delegate = self //set delegate to textfield
    }
    
    func textFieldShouldReturn(currencyTextField: UITextField) -> Bool {   //delegate method
        self.convertCurrencyButtonPressed(nil)
        currencyTextField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertCurrencyButtonPressed(sender: UIButton?) {
        // Convert it to a number if it is one
        var numberInput = currencyTextField.text as String
        
        // Remove the $ character from beginning of string
        if (numberInput[0] == "$") {
            var length = count(numberInput)
            numberInput = numberInput[1...length-1]
        }
        var amount = (numberInput as NSString).doubleValue
        
        if (amount == 0) {
            answerLabel.text = "Zero dollars"
        } else if (amount > 999999999999999) {
            // Give an alert and don't do anything else but clear the textbox
            currencyTextField.text = ""
            displayAlert("You have way too much money", message: "That's too large a number, try something smaller", style: .Alert)
        }
        else {
            convertToCurrencyString(amount)
            
            // Create the fraction string
            let wholeAndFraction = modf(amount)
            var fraction = String(format: "%.0f", wholeAndFraction.1*100)
            println(fraction)
            var fractionString = " and \(fraction)/100 dollars"
            
            var currencyString = writtenNumber(Int(amount)) + fractionString
            
            currencyString = currencyString[0].capitalizedString + currencyString[1...count(currencyString)-1]
            
            answerLabel.text = currencyString
        }
    }
    
    func convertToCurrencyString(amount: Double) {
        // Round the amount given so we only have 2 decimal places
        //var roundedAmount = (String(format: "%f", fraction) as NSString).doubleValue
    }
    
    func writtenNumber(num: Int) -> String {
        // Rules for converting to string
        // 1. thousand = 10^3, million = 10^6, billion = 10^9, trillion = 10^12, quadrillion = 10^15, quintillion = 10^18
        // 2. Hyphenate all compound numbers from twenty-one through ninety-nine, but not if a zero follows (divisible by 10)
        // 3. Decimals will be written ##/100, even if 00/100
        // 4. Hundreds come after the commas
        // 5. Numbers 11 - 19 are special case
        
        let hundred = 100
        let thousand = 1000
        let million = 1000000
        let billion = 1000000000
        let trillion = 1000000000000
        let quadrillion = 1000000000000000
        // Any higher and you overflow the int variable
        
        var space = "" // In the event you have numbers or zeros following the number being worked on
        
        var numberString = ""
        
        if (num < 10) {
            switch num {
            case 0:
                numberString = ""
            case 1:
                numberString = "one"
            case 2:
                numberString = "two"
            case 3:
                numberString = "three"
            case 4:
                numberString = "four"
            case 5:
                numberString = "five"
            case 6:
                numberString = "six"
            case 7:
                numberString = "seven"
            case 8:
                numberString = "eight"
            case 9:
                numberString = "nine"
            default:
                numberString = "default1"
            }
        } else if (num > 9 && num < 20) {
            switch num {
            case 10:
                numberString = "ten"
            case 11:
                numberString = "eleven"
            case 12:
                numberString = "twelve"
            case 13:
                numberString = "thirteen"
            case 15:
                numberString = "fifteen"
            case 18:
                numberString = "eighteen"
            default:
                numberString = writtenNumber(num-10) + "teen"
            }
        } else if (num > 19 && num < 100) {
            // The tens
            switch num {
            case 20:
                numberString = "twenty"
            case 30:
                numberString = "thirty"
            case 40:
                numberString = "forty"
            case 50:
                numberString = "fifty"
            case 60:
                numberString = "sixty"
            case 70:
                numberString = "seventy"
            case 80:
                numberString = "eighty"
            case 90:
                numberString = "ninety"
            default:
                numberString = writtenNumber(num/10*10) + "-" + writtenNumber(num % 10)
            }
        }
        // -------------- The hundreds ----------------
        else if (num > (hundred-1) && num < thousand) {
            if ((num % hundred) != 0) { space = " " }
            numberString = writtenNumber(num/hundred) + " hundred" + space + writtenNumber(num % hundred)
        }
        // -------------- The thousands ----------------
        else if (num > (thousand-1) && num < million) {
            if ((num % thousand) != 0) { space = " " }
            numberString = writtenNumber(num/thousand) + " thousand" + space + writtenNumber(num % thousand)
        }
        // -------------- The hundreds ----------------
        else if (num > (million - 1) && num < billion) {
            if ((num % million) != 0) { space = " " }
            numberString = writtenNumber(num/million) + " million" + space + writtenNumber(num % million)
        }
        // -------------- The billions ----------------
        else if (num > (billion - 1) && num < trillion) {
            if ((num % billion) != 0) { space = " " }
            numberString = writtenNumber(num/billion) + " billion" + space + writtenNumber(num % billion)
        }
        // -------------- The trillions ----------------
        else if (num > (trillion - 1) && num < quadrillion) {
            if ((num % trillion) != 0) { space = " " }
            numberString = writtenNumber(num/trillion) + " trillion" + space + writtenNumber(num % trillion)
        }
        else {
            numberString = "Something something something"
        }
        return numberString
    }
    
    func displayAlert(title:String, message:String, style: UIAlertControllerStyle) {
        // Make an error message alert
        //1. Create the alert controller.
        var alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

