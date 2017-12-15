//
//  ManualEntryController.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import UIKit

class ManualEntryController: UIViewController, UITextFieldDelegate {

    var imageView = UIImageView()
    var name = UITextField()
    var ccNumber = UITextField()
    var expiration = UIView()
    var expMonth = UITextField()
    var expYear = UITextField()
    var cvc = UITextField()
    var continueButton = UIButton()
    var verifyLabel = UILabel()
    
    var amount: String = ""
    var email: String = ""
    
    var donorInfo = [DonorInfo]()
    
    var cardValid = CardValid()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "CreditCard Info"
        //self.scrollView.delegate = self
        
        getStyle()

    }
    
    func getStyle() {
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        imageView.image = UIImage(named: "helpingHand")
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        name.delegate = self
        self.view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        name.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        name.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        name.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        name.layer.borderWidth = 1
        name.layer.cornerRadius = 15
        name.keyboardType = .alphabet
        name.placeholder = "Full Name"
        name.textAlignment = .center
        
        self.view.addSubview(ccNumber)
        ccNumber.translatesAutoresizingMaskIntoConstraints = false
        ccNumber.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
        ccNumber.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        ccNumber.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        ccNumber.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        ccNumber.layer.borderWidth = 1
        ccNumber.layer.cornerRadius = 15
        ccNumber.keyboardType = .numberPad
        ccNumber.placeholder = "Credit Card Number"
        ccNumber.addTarget(self, action: #selector(ccTextFieldDidChange), for: .editingDidEnd)
        ccNumber.textAlignment = .center
        
        self.view.addSubview(expiration)
        expiration.translatesAutoresizingMaskIntoConstraints = false
        expiration.topAnchor.constraint(equalTo: ccNumber.bottomAnchor, constant: 20).isActive = true
        expiration.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        expiration.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        expiration.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
        expiration.addSubview(expMonth)
        expMonth.translatesAutoresizingMaskIntoConstraints = false
        expMonth.widthAnchor.constraint(equalTo: expiration.widthAnchor, multiplier: 0.40).isActive = true
        expMonth.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        expMonth.topAnchor.constraint(equalTo: expiration.topAnchor).isActive = true
        expMonth.leftAnchor.constraint(equalTo: expiration.leftAnchor).isActive = true
        expMonth.layer.borderWidth = 1
        expMonth.layer.cornerRadius = 15
        expMonth.keyboardType = .numberPad
        expMonth.placeholder = "Exp. Month xx"
        expMonth.textAlignment = .center
        
        expiration.addSubview(expYear)
        expYear.translatesAutoresizingMaskIntoConstraints = false
        expYear.widthAnchor.constraint(equalTo: expiration.widthAnchor, multiplier: 0.40).isActive = true
        expYear.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        expYear.topAnchor.constraint(equalTo: expiration.topAnchor).isActive = true
        expYear.rightAnchor.constraint(equalTo: expiration.rightAnchor).isActive = true
        expYear.layer.borderWidth = 1
        expYear.layer.cornerRadius = 15
        expYear.keyboardType = .numberPad
        expYear.placeholder = "Exp. Year xxxx"
        expYear.textAlignment = .center
        
        self.view.addSubview(cvc)
        cvc.translatesAutoresizingMaskIntoConstraints = false
        cvc.topAnchor.constraint(equalTo: expiration.bottomAnchor, constant: 20).isActive = true
        cvc.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        cvc.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        cvc.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cvc.layer.borderWidth = 1
        cvc.layer.cornerRadius = 15
        cvc.keyboardType = .numberPad
        cvc.placeholder = "CVC Code"
        cvc.textAlignment = .center
        
        self.view.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.topAnchor.constraint(equalTo: cvc.bottomAnchor, constant: 30).isActive = true
        continueButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        continueButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        continueButton.backgroundColor = UIColor.orange
        continueButton.layer.cornerRadius = 15
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(continued), for: .touchUpInside)
        
        self.view.addSubview(verifyLabel)
        verifyLabel.translatesAutoresizingMaskIntoConstraints = false
        verifyLabel.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20).isActive = true
        verifyLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        verifyLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.04).isActive = true
        verifyLabel.textAlignment = .center
        verifyLabel.textColor = UIColor.red
        verifyLabel.font = UIFont(name: "Times", size: 10)
        
    }
    
    @objc func ccTextFieldDidChange() {
        if let cc = ccNumber.text {
            if cardValid.validate(string: cc) {
                ccNumber.layer.borderColor = UIColor.green.cgColor
                print("card is valid")
            } else {
                ccNumber.layer.borderColor = UIColor.red.cgColor
                print("card is invalid")
            }
        }
    }
        
        func validateDate(month: String, year: String) -> Bool {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM"
            
            let someDate = year + "-" + month
            
            if dateFormatterGet.date(from: someDate) != nil {
                return true
            } else {
                return false
            }
        }
    
    @objc func continued() {
        let verifyVC = VerifyTransactionController()
        var type: String = ""
        if let cc = ccNumber.text {
            if cardValid.validate(string: cc) {
                if let cardtype = (cardValid.type(from: cc)?.name) {
                    type = cardtype
                }
                
                if let month = expMonth.text {
                    if let year = expYear.text {
                            if validateDate(month: month, year: year) {
                                if name.text != "" {
                                    if let named = name.text {
                                        verifyVC.name = named
                                    }
                                    
                                    if let cc = ccNumber.text {
                                        verifyVC.ccNumber = cc
                                    }
                                    
                                    if let mon = expMonth.text {
                                        verifyVC.expMonth = mon
                                    }
                                    
                                    if let year = expYear.text {
                                        verifyVC.expYear = year
                                    }
                                    
                                    if let code = cvc.text {
                                        verifyVC.cvc = code
                                    }
                                    
                                    verifyVC.cardType = type
                                    
                                    verifyVC.email = email
                                    
                                    self.navigationController?.pushViewController(verifyVC, animated: true)
                                    
                                } else{
                                    verifyLabel.text = "Name field is empty. Enter name and try again."
                                }
                            } else{
                                verifyLabel.text = "Invalid Date. Enter date and try again."
                        }
                        }
                }
            } else {
                verifyLabel.text = "Invalid credit card. Enter another card and try again."
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
