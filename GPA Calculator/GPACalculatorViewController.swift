//
//  ViewController.swift
//  GPA Calculator
//
//  Created by Eric Goodwin on 7/27/17.
//  Copyright © 2017 umsl. All rights reserved.
//

import UIKit


class GPACalculatorViewController: UIViewController {
    
    let model = GPACalculatorModel()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var projectGPADisplay: UITextField!
    
   
    @IBOutlet weak var currentGPAField: UITextField!
    @IBOutlet weak var currentCreditHoursField: UITextField!
    

    @IBOutlet  weak var tappableBackgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 64
        model.delegate = self
        

        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tappableBackgroundView.addGestureRecognizer(tapGestureRecognizer)
        tappableBackgroundView.isHidden = true
        
        currentGPAField.delegate = self
        currentCreditHoursField.delegate = self
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? AddClassViewController {
            destination.delegate = self
        } else if let destination = segue.destination as? CourseListDetailsViewController,
            let index = sender as? Int,
            let classDetail = model.classToShow(atIndex: index)  {
            
            destination.index = index
            destination.classDetail = classDetail
            destination.delegate = self        }
    }
    

    @IBAction func calculateProjectedGPA(_ sender: Any) {
        model.setInitialGPA(currentGPAField.text ?? "")
        model.setinitialCreditHours(currentCreditHoursField.text ?? "")
        projectGPADisplay.text = model.calculateProjectedGPA()
    }
    
    @objc private func backgroundTapped() {
        self.view.endEditing(true)
        tappableBackgroundView.isHidden = true
    }

    

}

extension GPACalculatorViewController: CourseListDetailsDelegate{
    func classToEdit(atIndex index: Int, classToEdit: Class) {
        model.classToEdit(atIndex: index, classToEdit: classToEdit)
    }
}

extension GPACalculatorViewController: AddClassViewControllerDelegate{
    func save(classToAdd: Class){
        model.save(classToAdd: classToAdd)
         
    }
}

extension GPACalculatorViewController: GPACalculatorModelDelegate {
    func dataRefreshed() {
        tableView.reloadData()
    }
}
extension GPACalculatorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "classCell",
                                                     for: indexPath) as? ClassListTableViewCell,
            let classToShow = model.classToShow(atIndex: indexPath.row)
            else { return UITableViewCell() }
        
        cell.decorate(with: classToShow)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            model.classToDelete(atIndex: indexPath.row)
        }
    }
    
    
}

extension GPACalculatorViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCourseDetails", sender: indexPath.row)
    }
}


extension GPACalculatorViewController: UITextFieldDelegate {
    
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
