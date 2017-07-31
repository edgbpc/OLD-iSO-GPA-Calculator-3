//
//  CourseListDetailsViewController.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/29/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import UIKit

protocol CourseListDetailsDelegate: class {
    func classToEdit(atIndex index:Int, classToEdit: Class)
}

class CourseListDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: CourseListDetailsDelegate?
    
    var index: Int = 0
    var classes = [Class]()
    var classDetail: Class?

    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var gradeReceived: UITextField!
    @IBOutlet weak var creditHoursWorth: UITextField!
    @IBOutlet weak var gradePointsEarned: UITextField!
    @IBOutlet weak var wasSubstituteLabel: UITextField!
    @IBOutlet weak var substituteSwitcher: UISwitch!
    
    @IBOutlet weak var perviousGradeField: UITextField!
    
    @IBOutlet weak var replacedGradeField: UITextField!
    @IBOutlet weak var previousGradePicker: UIPickerView!
   
    @IBOutlet weak var replacedPointsField: UITextField!
    @IBOutlet weak var newGradePicker: UIPickerView!
    
    
      var gradePickerData = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F", "FN"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.previousGradePicker.delegate = self
        self.previousGradePicker.dataSource = self
        
        self.newGradePicker.delegate = self
        self.previousGradePicker.dataSource = self
        
 
        
        previousGradePicker.isHidden = true
        newGradePicker.isHidden = true
        substituteSwitcher.isHidden = true
        
        guard let classDetail = self.classDetail else { return }
        courseNameField.text = classDetail.courseName
        gradeReceived.text = classDetail.newGrade
        creditHoursWorth.text = String(classDetail.creditHour)
        gradePointsEarned.text = String(classDetail.creditHour * classDetail.getGradePointValue())
        
        if classDetail.substitute {
        wasSubstituteLabel.text = "Yes"
        replacedGradeField.text = classDetail.previousGrade
        replacedPointsField.text = String(classDetail.creditHour * classDetail.getPreviousGradePointValue())
        }else {
            wasSubstituteLabel.text = "No"
            replacedGradeField.text = "N/A"
            replacedPointsField.text = "N/A"
        }
    

        // Do any additional setup after loading the view.
    }

    @IBAction func enableEditing(_ sender: Any) {
        courseNameField.isEnabled = true
        gradeReceived.isEnabled = true
        creditHoursWorth.isEnabled = true
        gradePointsEarned.isEnabled = false
       
        wasSubstituteLabel.isHidden = true
        substituteSwitcher.isHidden = false
        
        perviousGradeField.isHidden = true
        gradeReceived.isHidden = true
        
        previousGradePicker.isHidden = false
        newGradePicker.isHidden = false
        
        
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        
    
    
        let classToEdit = Class(substitute: substituteSwitcher.isOn, courseName: courseNameField.text!, creditHour: Double(creditHoursWorth.text!)!, previousGrade: gradePickerData[previousGradePicker.selectedRow(inComponent: 0)], newGrade: gradePickerData[newGradePicker.selectedRow(inComponent: 0)])
        
        delegate?.classToEdit(atIndex: index, classToEdit: classToEdit)
        let _ = navigationController?.popViewController(animated: true)
        
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradePickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradePickerData[row]
    }
    
    // Catpure the picker view selection
    @nonobjc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String  {
        
        return gradePickerData[row] as String
        
        
    }



}
