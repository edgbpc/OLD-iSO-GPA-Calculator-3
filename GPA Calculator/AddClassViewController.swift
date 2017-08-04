//
//  AddClassViewController.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/27/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import UIKit

protocol AddClassViewControllerDelegate: class{
    func save(classToAdd: Class)
}

class AddClassViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: AddClassViewControllerDelegate?
    
    @IBOutlet weak var creditHoursLabel: UILabel!
    
    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var isSubstituteSwitch: UISwitch!
    @IBOutlet weak var creditHoursField: UITextField!
    @IBOutlet weak var previousGradePicker: UIPickerView!
    @IBOutlet weak var newGradePicker: UIPickerView!
    @IBOutlet weak var previousGradeLabel: UILabel!
    
    @IBOutlet weak var tappableBackgroundView: UIView!
    
    var gradePickerData: [String] = [String]()
    var previousGradePickerData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.previousGradePicker.delegate = self
        self.previousGradePicker.dataSource = self
        
        self.newGradePicker.delegate = self
        self.previousGradePicker.dataSource = self
        
        gradePickerData = ["No Grade", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F", "FN"]
        
        previousGradePickerData = ["C-", "D+", "D", "D-", "F", "Fn"]
        
        //start with switch off
        
        isSubstituteSwitch.isOn = false
        previousGradePicker.isUserInteractionEnabled = false
        previousGradePicker.isHidden = true
        previousGradeLabel.isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tappableBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        tappableBackgroundView.isHidden = true
        
        courseNameField.delegate = self
        creditHoursField.delegate = self
        
       
    }
    
    @IBAction func enterCourseName(_ sender: UITextField) {
        
    }
    
    @IBAction func substituteSwitchFlipped(_ sender: Any) {
         if isSubstituteSwitch.isOn {
            previousGradePicker.isHidden = false
            previousGradePicker.isUserInteractionEnabled = true
            previousGradeLabel.isHidden = false
        } else {
            previousGradePicker.isHidden = true
            previousGradeLabel.isHidden = true
            previousGradePicker.isUserInteractionEnabled = false
        }
    }
    @IBAction func commitClassButtonTapped(_ sender: Any) {
        let courseName = courseNameField.text ?? ""
        let isSubstitue = isSubstituteSwitch.isOn
        guard let creditHours = Double(creditHoursField.text!) else  { creditHoursLabel.textColor = UIColor.red; return }
       
        let previousGrade = previousGradePickerData[previousGradePicker.selectedRow(inComponent: 0)]
        let newGrade = gradePickerData[newGradePicker.selectedRow(inComponent: 0)]


        
  
        
       
        let classToAdd = Class(substitute: isSubstitue, courseName: courseName, creditHour: creditHours, previousGrade: previousGrade, newGrade: newGrade)
//
        delegate?.save(classToAdd: classToAdd)
        let _ = navigationController?.popViewController(animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if newGradePicker == pickerView {
            return gradePickerData.count
        } else {
            return previousGradePickerData.count
        }
    }
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if newGradePicker == pickerView {
            return gradePickerData[row]
        } else {
            return previousGradePickerData[row]
        }
    }
    // Catpure the picker view selection
    @nonobjc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) -> String  {
    
        return gradePickerData[row] as String
        
   
    }

    
    @objc private func backgroundTapped() {
        self.view.endEditing(true)  
        tappableBackgroundView.isHidden = true
    }

}

extension AddClassViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tappableBackgroundView.isHidden = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        tappableBackgroundView.isHidden = true
        return true
}

}


