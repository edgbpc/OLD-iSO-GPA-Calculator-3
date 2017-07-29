//
//  Utilities.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/28/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        if index < 0 { return nil }
        if index >= self.count { return nil }
        return self[index]
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
