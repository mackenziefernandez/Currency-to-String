//
//  ViewController.swift
//  Currency to String
//
//  Created by Mackenzie Fernandez on 7/29/15.
//  Copyright (c) 2015 Mackenzie Fernandez. All rights reserved.
//

import UIKit

//extension Int {
//    var array: [Int] {
//        return Array(description).map{String($0).toInt() ?? 0}
//    }
//}

class ViewController: UIViewController {

    @IBOutlet weak var currencyTextField: UITextField!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for var i=999; i<10000; i=i+2 {
            println(writtenNumber(i))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertCurrencyButtonPressed(sender: UIButton) {
        // Convert it to a number if it is one
        var numberInput = currencyTextField.text as NSString
        var amount = numberInput.doubleValue
        
        if (amount == 0) {
            answerLabel.text = "zero dollars"
        } else {
            convertToCurrencyString(amount)
        }
        
        
//        if (currencyTextField.text.toInt() != nil ) {
//            // It is a number but has no decimals following
//            // Function call to convert the number to a string
//            convertToCurrencyString(amount)
//
//        } else if (amount >= 0.0) {
//            //
//            println("amount is >= 0.0")
//        } else {
//            // It is not a number!
//            displayAlert("Not A Number", message: "Pretty sure that's not a number, dude", style: .Alert)
//        }
        
    }
    
    func convertToCurrencyString(amount: Double) {
        // Round the amount given so we only have 2 decimal places
        var roundedAmount = (String(format: "%.2f", amount) as NSString).doubleValue
        
        // Create the fraction string
        var integer = 0.0
        let fraction = modf(roundedAmount, &integer)
        var fractionString = " and \(Int(fraction*100))/100 dollars"
        
        //println(fractionString)
        
        var currencyString = writtenNumber(Int(amount)) + fractionString
        
        println(currencyString)
    }
    
    func writtenNumber(num: Int) -> String {
        // Rules for converting to string
        // 1. thousand = 10^3, million = 10^6, billion = 10^9, trillion = 10^12, quadrillion = 10^15, quintillion = 10^18, sextillion = 10^21
        // 2. Hyphenate all compound numbers from twenty-one through ninety-nine, but not if a zero follows (divisible by 10)
        // 3. Decimals will be written ##/100, even if 00/100
        // 4. Hundreds come after the commas
        // 5. Numbers 11 - 19 are special case
        
        let hundred = 100
        let thousand = 1000
        let million = 10^6
        let billion = 10^9
        let trillion = 10^12
        let quadrillion = 10^15
        let quintillion = 10^18
        let sextillion = 10^21
        let septillion = 10^24
        
        
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
        } else if (num > (hundred-1) && num < thousand) {
            // The hundreds
            numberString = writtenNumber(num/hundred) + " hundred " + writtenNumber(num % hundred)
        } else if (num >= thousand && num < million) {
            // The thousands
            numberString = writtenNumber(num/thousand) + " thousand " + writtenNumber(num % thousand)
        } else if (num > (million - 1) && num < billion) {
            // The millions
            numberString = writtenNumber(num/million) + " million " + writtenNumber(num % million)
        } else if (num > (billion - 1) && num < trillion) {
            // The billions
            numberString = writtenNumber(num/billion) + " billion " + writtenNumber(num % billion)
        } else if (num > (trillion - 1) && num < quadrillion) {
            // The trillions
            numberString = writtenNumber(num/trillion) + " trillion " + writtenNumber(num % trillion)
        } else if (num > (quadrillion - 1) && num < quintillion) {
            // The quadrillions
            numberString = writtenNumber(num/quadrillion) + " quadrillion " + writtenNumber(num % quadrillion)
        } else if (num > (quintillion - 1) && num < sextillion) {
            // The quintillions
            numberString = writtenNumber(num/quintillion) + " quintillion " + writtenNumber(num % quintillion)
        } else if (num > (sextillion - 1) && num < septillion) {
            // The sextillions
            numberString = writtenNumber(num/sextillion) + " sextillion " + writtenNumber(num % sextillion)
        } else {
            numberString = "default2"
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

