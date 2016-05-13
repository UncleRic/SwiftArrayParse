//  Algorithms.swift
//  SwiftArrayParse
//
//  Created by Frederick C. Lee on 5/13/16.
//  Copyright © 2016 Amourine Technologies. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation

// Scenario:
// Initial array: [3,0,6,1,2,0,1]
// Shift all non-zero numerals to one-side of the array and count them.
// This is to be done in O(n) with space complexity of O(1).
// Resultant Array: [3,6,1,2,1,0,0] - Don't worry about sorting.

func putZeroesToLeft(inout nums: [Int]) {
    assert(!nums.isEmpty)
    
    var firstAvailableSlot = (nums[0] == 0) ? 1:0
    
    for index in firstAvailableSlot..<nums.count {
        if nums[index] == 0 {
            swap(&nums[firstAvailableSlot], &nums[index])
            firstAvailableSlot += 1
        }
        
    }
}

// ===================================================================================================

