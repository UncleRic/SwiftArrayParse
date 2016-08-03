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
    
    var orderedIntSet = NSOrderedSet()
    let acceptableCharacters: Set<String> = ["1","2","3","4","5","6","7","8","9","0",","]
    let emptyDataString = "-- Missing Input ---"
    
    override func viewDidLayoutSubviews() {
        self.answerView.textColor = UIColor.brown
        self.toolbar.tintColor = UIColor.brown
        
        var tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.handleViewTap))
        self.view.addGestureRecognizer(tapRecognizer)
        tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.handleDataFieldTap))
        self.dataInputField.addGestureRecognizer(tapRecognizer)
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Gesture Handlers
    
    func handleViewTap() {
        self.dataInputField.resignFirstResponder()
        self.sumEntryField.resignFirstResponder()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func handleDataFieldTap() {
        if self.dataInputField.text == emptyDataString {
            self.dataInputField.text = ""
            self.sumEntryField.text = ""
            self.dataInputField.textColor = UIColor.black
            self.dataInputField.becomeFirstResponder()
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func Reset(_ sender: UIBarButtonItem) {
        self.dataInputField.text = ""
        self.dataInputField.becomeFirstResponder()
        self.sumEntryField.text = ""
        self.answerView.text = ""
    }
    
    @IBAction func exitAction(_ sender: UIBarButtonItem) {
        exit(0)
    }
    
}

// ===================================================================================================
// MARK: - UITextFieldDelege Methods

extension ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isSum = (textField.tag == 2)
        textField.resignFirstResponder()
        
        if isSum {
            orderedIntSet = []
            if let x = textField.text {
                if x.isEmpty {
                    return false
                }
                // 1) Convert to array of Int, 2) Sort, 3) Make Unique via Set, 4) change to Array.
                if disseminate(dataInputField.text!) {
                    processArray(Int(x)!)
                } else {
                    self.dataInputField.textColor = UIColor.red
                    self.dataInputField.text = emptyDataString
                }
            }
        } else {
            if (textField.text!.isEmpty) {
                textField.text = textField.placeholder
                self.sumEntryField.becomeFirstResponder()
            }
        }
        return true
    }
    
    // -----------------------------------------------------------------------------------------------------
    // Filtering out input garbage:
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn
        range: NSRange, replacementString string: String) -> Bool {
        return acceptableCharacters.contains(string)
    }
    
    
}




