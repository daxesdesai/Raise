//
//  AmountController.swift
//  Raise
//
//  Created by dkdesai on 12/15/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import UIKit

class AmountController: UIViewController, UITextFieldDelegate {

    var emailField = UITextField()
    var amountField = UITextField()
    var donateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let logo = UIImage(named: "logo")
        self.navigationItem.titleView = UIImageView(image: logo)
    }
    
    func getStyle() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "charity")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.emailField.delegate = self
        self.view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emailField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -87.5).isActive = true
        emailField.backgroundColor = UIColor.white
        emailField.textAlignment = .center
        emailField.font = UIFont(name: "Times", size: 20)
        emailField.keyboardType = .emailAddress
        emailField.layer.cornerRadius = 15
        emailField.placeholder = "Email Address"
        
        self.amountField.delegate = self
        self.view.addSubview(amountField)
        amountField.translatesAutoresizingMaskIntoConstraints = false
        amountField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        amountField.heightAnchor.constraint(equalToConstant: 75).isActive = true
        amountField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        amountField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        amountField.backgroundColor = UIColor.white
        amountField.textAlignment = .center
        amountField.font = UIFont(name: "Times", size: 30)
        amountField.keyboardType = .numberPad
        amountField.layer.cornerRadius = 15
        amountField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        amountField.placeholder = "Enter Amount"
        
        self.view.addSubview(donateButton)
        donateButton.translatesAutoresizingMaskIntoConstraints = false
        donateButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 20).isActive = true
        donateButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        donateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        donateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        donateButton.backgroundColor = UIColor.orange
        donateButton.setTitle("Donate", for: .normal)
        donateButton.addTarget(self, action: #selector(addDetails), for: .touchUpInside)
        donateButton.layer.cornerRadius = 15

    }
    
    @objc func addDetails() {
        
        if amountField.text != "" {
            let manualVC = ManualEntryController()
            
            if let amountEntered = amountField.text {
                manualVC.amount = amountEntered
                if let email = emailField.text {
                    manualVC.email = email
                }
                self.navigationController?.pushViewController(manualVC, animated: true)
            }
        } else {
            amountField.placeholder = "Invalid Amount"
            amountField.layer.borderWidth = 2
            amountField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        amountField.layer.borderWidth = 0
        amountField.layer.borderColor = UIColor.clear.cgColor
        amountField.placeholder = "Enter Amount"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
