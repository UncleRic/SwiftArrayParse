//  ArrayMemberSum.swift
//  SwiftArrayParse
//
//  Created by Frederick C. Lee on 5/14/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation

extension ViewController {
    func disseminate(_ string:String) -> Bool {
        let intArray = string.characters.split(separator: ",").flatMap{ Int(String($0)) }
        orderedIntSet = NSOrderedSet.init(array: intArray)
        return orderedIntSet.count > 0
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func resetDataInputWithCleansedData(_ set:NSOrderedSet) {
        guard set.count > 0 else {
            return;
        }
        var myString:String = ""
        for member in set {
            if let numb = member.int32Value {
                myString += (String(numb))
                myString += ","
            }
        }
        myString.remove(at: myString.index(before: myString.endIndex)) // remove last ','
        self.dataInputField.text = myString
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func processArray(_ sum:Int) {
        resetDataInputWithCleansedData(orderedIntSet)
        var chosenSet = Set<Int>()
        var msg = ""
        if orderedIntSet.contains(sum) {
            msg = "Entered Sum '\(sum)' was found within the data source.\n"
        }
        var tupleArray = [(Int,Int)]()
        
        for x in orderedIntSet {
            let xInt = Int(x as! NSNumber)
            let y = sum - xInt
            if orderedIntSet.contains(y) {
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
    
}
