//
//  GPACalculatorModel.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/27/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import Foundation

struct Class {
    let className: String
    let creditHour: Double
    let Grades : [String:Double] = ["A":4.0, "A-":3.7, "B+":3.0, "B":3.0, "B-":2.7, "C+":2.3, "C":2.0, "C-":1.7, "D+":1.3, "D":1.0, "D-":0.7, "F":0, "FN":0]
    
}


class GPACalculatorModel {

    private var classes = [Class]()
    
    private var initialGPA: Double?
    private var initialCreditHours: Double?
    
    
    
    
    init(){  }
    
    
    func setInitialGPA(_ input: String){
        initialGPA = Double(input)
    }
    
    func setinitialCreditHours(_ input: String) {
        initialCreditHours = Double(input)
    }
}
