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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = 64
        model.delegate = self
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? AddClassViewController {
            destination.delegate = self
        }
    }
    

    @IBAction func calculateProjectedGPA(_ sender: Any) {
        projectGPADisplay.text = model.calculateProjectedGPA()
    }
    
    
    @IBAction func enterCurrentGPA(_ sender: UITextField) {
        model.setInitialGPA(sender.text ?? "")
    
    }

    @IBAction func enterInitialGPA(_ sender: UITextField) {
        model.setinitialCreditHours(sender.text ?? "")
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
        cell.accessoryType = UITableViewCellAccessoryType.none
        return cell
    }
}


