//
//  AddClassViewController.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/27/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import UIKit

protocol AddClassViewControllerDelegate: class{
    func save(class: Class)
}

class AddClassViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: AddClassViewControllerDelegate?

    @IBOutlet weak var previousGradePicker: UIPickerView!
    
    var gradePickerData: [String] = [String]()
    
    @IBOutlet weak var newGradePicker: UIPickerView!
    
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
        
        
        //left off here
        let tempClass = Class(className: "className", creditHour: 50 )
        
        delegate?.save(class: tempClass)
        
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
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
