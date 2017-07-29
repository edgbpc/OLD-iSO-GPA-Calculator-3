//
//  ClassListTableViewCell.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/28/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import UIKit


class ClassListTableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var courseName: UILabel!
    
    @IBOutlet weak var gradePoints: UILabel!
    
    func decorate(with classToShow: Class) {
        courseName.text = classToShow.courseName
        gradePoints.text = String(classToShow.creditHour * classToShow.getGradePointValue())
        
   
    

    }
}
