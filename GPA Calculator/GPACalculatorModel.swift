//
//  GPACalculatorModel.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/27/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import Foundation

protocol GPACalculatorModelDelegate: class {
    func dataRefreshed()
}

struct Class {
    let substitute: Bool
    let courseName: String
    let creditHour: Double
    let previousGrade: String
    let newGrade: String

    func getGradePointValue() -> Double {
        switch newGrade {
        case "No Grade" : return 0  //classes with No Grade does add to grade points
        case "A" : return 4.0
        case "A-" : return 3.7
        case "B+" : return 3.3
        case "B" : return 3.0
        case "B-" : return 2.7
        case "C+" : return 2.3
        case "C" : return 2.0
        case "C-" : return 1.7
        case "D+" : return 1.3
        case "D" : return 1.0
        case "D-" : return 0.7
        case "F" : return 0
        case "FN" : return 0
        default: return 0
        }
    }

    func getPreviousGradePointValue() -> Double {
        switch previousGrade{
        case "C-" : return 1.7
        case "D+" : return 1.3
        case "D" : return 1.0
        case "D-" : return 0.7
        case "F" : return 0
        case "FN" : return 0
        default: return 0
        }
    
    }
    
}


class GPACalculatorModel {

    private var classes = [Class]()
    
    weak var delegate: GPACalculatorModelDelegate?
    
    private var initialGPA: Double = 0
    private var initialCreditHours: Double = 0
    private var initialGradePoints: Double {
        return (initialGPA * initialCreditHours)
    }
    private var projectedGPA: Double = 0
    
    //unused
//    let gradePointValues : [String:Double] = ["A":4.0, "A-":3.7, "B+":3.3, "B":3.0, "B-":2.7, "C+":2.3, "C":2.0, "C-":1.7, "D+":1.3, "D":1.0, "D-":0.7, "F":0, "FN":0]
    
    
    var count: Int {
        return classes.count
    }
    

    
    func calculateNewGradePoints() -> Double {
        var sumOfNewGradePoints: Double = 0
        
        for index in 0..<classes.count {
         
            sumOfNewGradePoints += (classes[index].getGradePointValue()*classes[index].creditHour)
           }
        
        return sumOfNewGradePoints
    }
    
    func calculateNewCreditHoursCompleted() -> Double {
        var sumOfNewCreditHoursCompleted: Double = 0
        
        for index in 0..<classes.count {
            //class with No Grade selected do not increase completed hours
            if classes[index].newGrade != "No Grade"{
                sumOfNewCreditHoursCompleted += (classes[index].creditHour)
            }
            
        }
        return sumOfNewCreditHoursCompleted
    }
    
    func calculateSubstitutedGradePointsToRemove() -> Double {
        var substitutedGradePointsToRemove: Double = 0
        
        for index in  0..<classes.count{
            if classes[index].substitute {
                substitutedGradePointsToRemove += (classes[index].creditHour * classes[index].getPreviousGradePointValue())            }
        }
            return substitutedGradePointsToRemove
    }
    
    func calculateSubstitutedCreditHoursToRemove() -> Double {
        var substitutedCreditHoursToRemove: Double = 0
        
        for index in  0..<classes.count {
            if classes[index].substitute {
                substitutedCreditHoursToRemove += (classes[index].creditHour)
            }
        }
        return substitutedCreditHoursToRemove

    }
    
    
    
    func calculateProjectedGPA() -> String {
        
        let newGradePoints = initialGradePoints - calculateSubstitutedGradePointsToRemove() + calculateNewGradePoints()
       
        let newCreditHours = initialCreditHours - calculateSubstitutedCreditHoursToRemove() + calculateNewCreditHoursCompleted()
        
      
        
        
        let projectedGPA = newGradePoints/newCreditHours

        return String(projectedGPA.roundTo(places: 2))
    }




    //unused
//    func getClassesArray () -> [Class]{
//        return classes
//    }
    
    init(){}
    
    
    func getInitialGradePoints () -> Double {
        return initialGradePoints
    }
    
    func classToShow(atIndex index: Int) -> Class? {
        return classes.element(at: index)
    }
    
    func classToEdit(atIndex index:Int, classToEdit: Class){
        classes[index] = classToEdit
        delegate?.dataRefreshed()
    }
    
    func classToDelete(atIndex index:Int){
        classes.remove(at: index)
        delegate?.dataRefreshed()
    }
    
    
    func save(classToAdd: Class){
        classes.append(classToAdd)
        delegate?.dataRefreshed()
       // print(classes)
    }
    
    
    func setInitialGPA(_ input: String){
        
        initialGPA = Double(input) ?? 0
    }
    
    func setinitialCreditHours(_ input: String) {
        initialCreditHours = Double(input) ?? 0
    }
}
