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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? AddClassViewController {
            destination.delegate = self
        }
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
