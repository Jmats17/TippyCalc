//
//  ViewController.swift
//  TipCalculator
//
//  Created by Justin Matsnev on 11/7/19.
//  Copyright © 2019 Justin Matsnev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var subTotalTextfield : UITextField!
    @IBOutlet var taxTextfield : UITextField!
    @IBOutlet var tipControl : UISegmentedControl!
    @IBOutlet var totalAmtLbl : UILabel!
    @IBOutlet var calculateButton : UIButton! {
        didSet {
            calculateButton.layer.cornerRadius = 7.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateTapped(sender : UIButton) {
        view.endEditing(true)
        
        guard let subTotal = subTotalTextfield.text, subTotal != "" else {
            alertUser(field: "Sub Total", textField: subTotalTextfield)
            return
        }
        
        guard let tax = taxTextfield.text, tax != "" else {
            alertUser(field: "Tax", textField: taxTextfield)
            return
        }
        totalAmtLbl.text = String(format: "$%.2f", calculate((subTotal as NSString).doubleValue, (tax as NSString).doubleValue))
        
    }
    
    private func calculate(_ subTotal : Double,_ tax : Double) -> Double {
        let subAndTaxTotal = (subTotal * tax) + subTotal
        let tipAmt = subAndTaxTotal * returnTipAmount()
        return subAndTaxTotal + tipAmt
    }
    
    private func returnTipAmount() -> Double {
        switch tipControl.selectedSegmentIndex {
        case 0:
            return 0.15
        case 1:
            return 0.18
        case 2:
            return 0.20
        default:
            return 1.0
        }
    }
    
    private func alertUser(field : String, textField : UITextField) {
        let alertView = UIAlertController(title: "Missing Field!", message: "Uh Oh! You forgot to input a " + field + " amount." , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Got it", style: .default) { (action) in
            //self.dismiss(animated: true, completion: nil)
            textField.becomeFirstResponder()
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

