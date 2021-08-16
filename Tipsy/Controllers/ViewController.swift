//
//  ViewController.swift
//  Tipsy
//
//  Created by Ali Dinç on 16/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var totalBillValueTextField: UITextField!
    @IBOutlet weak var taxValueTextField: UITextField!
    @IBOutlet weak var customTipTextField: UITextField!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var calculateView: UIView!
    @IBOutlet weak var clearView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var percent10: UIButton!
    @IBOutlet weak var percent15: UIButton!
    @IBOutlet weak var percent18: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        calculateTipValue()
        view.endEditing(true)
        sender.resignFirstResponder()
        
        UIView.transition(with: calculateButton, duration: 0.50, options: .transitionCrossDissolve) {
            self.calculateButton.setTitleColor(.systemIndigo, for: .normal)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        totalBillValueTextField.text = ""
        taxValueTextField.text = ""
        customTipTextField.text = ""
        tipValueLabel.text = "Tip Value:   £..."
        totalValueLabel.text = "Total Value: £..."
        UIView.transition(with: calculateButton, duration: 0.75, options: .transitionCrossDissolve) {
            self.calculateButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func percen10tapped(_ sender: Any) {
        customTipTextField.text = "0.10"
    }
    
    @IBAction func percent15tapped(_ sender: Any) {
        customTipTextField.text = "0.15"
    }
    
    @IBAction func percent18tapped(_ sender: Any) {
        customTipTextField.text = "0.18"
    }
    
    // MARK: - Helpers
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func calculateTipValue() {
        guard let bill = Double(totalBillValueTextField.text!),
              let tipPlus = Double(customTipTextField.text!) else { return }
        let tax = Double(taxValueTextField.text!) ?? 0.0
        
        let total = bill + tax
        let tip = total * tipPlus
        let totalValue = total + tip
        tipValueLabel.text = "Tip Value:   £\(String(format: "%.2f", tip))"
        totalValueLabel.text = "Total Value: £\(String(format: "%.2f", totalValue))"
    }
    
    fileprivate func setupView() {
        calculateView.addCornerRadius(radius: 12)
        calculateView.backgroundColor = .label
        calculateButton.setTitleColor(.systemIndigo, for: .normal)
        percent10.addCornerRadius(radius: 5)
        percent15.addCornerRadius(radius: 5)
        percent18.addCornerRadius(radius: 5)
        customTipTextField.addCornerRadius(radius: 12)
        clearView.addCornerRadius(radius: 12)
        clearView.backgroundColor = .label
        clearButton.setTitleColor(.gray, for: .normal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
}

