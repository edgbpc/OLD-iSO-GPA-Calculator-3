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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func enterCurrentGPA(_ sender: UITextField) {
        model.setInitialGPA(sender.text ?? "")
    }

    @IBAction func enterInitialGPA(_ sender: UITextField) {
        model.setinitialCreditHours(sender.text ?? "")
    }
}

