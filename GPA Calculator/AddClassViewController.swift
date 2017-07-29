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
    
    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var isSubstituteSwitch: UISwitch!
    @IBOutlet weak var creditHoursField: UITextField!
    @IBOutlet weak var previousGradePicker: UIPickerView!
    @IBOutlet weak var newGradePicker: UIPickerView!
    
    var gradePickerData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.previousGradePicker.delegate = self
        self.previousGradePicker.dataSource = self
        
        self.newGradePicker.delegate = self
        self.previousGradePicker.dataSource = self
        
    gradePickerData = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F", "FN"]
    }
    
    @IBAction func enterCourseName(_ sender: UITextField) {
        
    }
    
    @IBAction func commitClassButtonTapped(_ sender: Any) {
        let courseName = courseNameField.text ?? ""
        let isSubstitue = isSubstituteSwitch.isOn
        let creditHours = Double(creditHoursField.text ?? "")
       
        let previousGrade = gradePickerData[previousGradePicker.selectedRow(inComponent: 0)]
        let newGrade = gradePickerData[newGradePicker.selectedRow(inComponent: 0)]

//        print(courseName)
//        print(isSubstitue)
//        print(creditHours ?? 0)
//        print(previousGrade)
//        print(newGrade)
        
  
        
        //left off here
        let classToAdd = Class(substitute: isSubstitue, courseName: courseName, creditHour: creditHours!, previousGrade: previousGrade, newGrade: newGrade)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


