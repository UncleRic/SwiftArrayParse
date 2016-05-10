//  ViewController.swift
//  ArrayParse
//
//  Created by Frederick C. Lee on 5/6/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dataInputField: UITextField!
    @IBOutlet weak var answerView: UITextView!
    @IBOutlet weak var sumEntryField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    
    var intArray = [Int]()
    let acceptableCharacters: Set<String> = ["1","2","3","4","5","6","7","8","9","0",","]
    
    override func viewDidLayoutSubviews() {
        self.answerView.textColor = UIColor.brownColor()
        self.toolbar.tintColor = UIColor.brownColor()
        
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.handleViewTap))
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func handleViewTap() {
        self.dataInputField.resignFirstResponder()
        self.sumEntryField.resignFirstResponder()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func disseminate(string:String) -> [Int] {
        return string.characters.split(",").flatMap{ Int(String($0)) }
    }
    
    func resetDataInputWithCleansedData(set:NSOrderedSet) {
        var myString:String = ""
        for member in set {
            myString += (String(member.intValue))
            myString += ","
        }
        myString.removeAtIndex(myString.endIndex.predecessor()) // remove last ','
        self.dataInputField.text = myString
    }
    
    // -----------------------------------------------------------------------------------------------------
    func processArray(sum:Int) {
        let orderedSet = NSOrderedSet(array:intArray)
        resetDataInputWithCleansedData(orderedSet)
        var chosenSet = Set<Int>()
        var msg = ""
        if orderedSet.containsObject(sum) {
            msg = "Entered Sum '\(sum)' was found within the data source.\n"
        }
        var tupleArray = [(Int,Int)]()
        
        for x in orderedSet {
            let xInt = Int(x as! NSNumber)
            let y = sum - xInt
            if orderedSet.containsObject(y) {
                if !chosenSet.contains(y) && !chosenSet.contains(xInt) {
                    if y != xInt {   // ... ignore numerals when doubled, equals sum.
                        tupleArray.append((xInt,y))
                    }
                    // Insert chosen numberals into the holding 'chosenSet' to avoid duplicate reporting.
                    chosenSet.insert(y)
                    chosenSet.insert(xInt)
                }
            }
        }
        
        if msg.isEmpty && tupleArray.isEmpty {
            self.answerView.text = "Sorry, there's no two numbers found."
        } else {
            for myTuple in tupleArray {
                let myMsg = "The sum of members \(myTuple.0) and \(myTuple.1) = \(sum).\n"
                msg += myMsg
            }
            self.answerView.text = msg
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func Reset(sender: UIBarButtonItem) {
        self.dataInputField.text = ""
        self.dataInputField.becomeFirstResponder()
        self.sumEntryField.text = ""
        self.answerView.text = ""
    }
    
    @IBAction func exitAction(sender: UIBarButtonItem) {
        exit(0)
    }
    
}

// ===================================================================================================
// MARK: - UITextFieldDelege Methods

extension ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let isSum = (textField.tag == 2)
        textField.resignFirstResponder()
        
        if isSum {
            
            intArray = []
            if let x = textField.text {
                if x.isEmpty {
                    return false
                }
                if intArray.isEmpty {
                    // 1) Convert to array of Int, 2) Sort, 3) Make Unique via Set, 4) change to Array.
                    intArray = Array(Set(disseminate(dataInputField.text!)))
                }
                processArray(Int(x)!)
                return true
            }
        } else {
            intArray = disseminate(textField.text!).sort()
        }
        return true
    }
    
    // -----------------------------------------------------------------------------------------------------
    // Filtering out input garbage:
    
    func textField(textField: UITextField, shouldChangeCharactersInRange
        range: NSRange, replacementString string: String) -> Bool {
        return acceptableCharacters.contains(string)
    }
}




