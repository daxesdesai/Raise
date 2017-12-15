//
//  VerifyTransactionController.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import UIKit

class VerifyTransactionController: UIViewController {
    
    var imageView = UIImageView()
    var centerView = UIView()
    var nameLabel = UILabel()
    var ccLabel = UILabel()
    var expLabel = UILabel()
    var cvcLabel = UILabel()
    var typeLabel = UILabel()
    var emailLabel = UILabel()
    var confirmButton = UIButton()
    var successImageView = UIImageView()
    var successLabel = UILabel()
    
    var name:String = ""
    var ccNumber:String = ""
    var expMonth:String = ""
    var expYear:String = ""
    var cvc:String = ""
    var cardType:String = ""
    var email:String = ""
    
    var httpClient: HttpClient!
    let session = FakeURLSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Confirm"
        
        getStyle()
        
        httpClient = HttpClient(session: session)
        
        //background task
        DispatchQueue.global(qos: .userInitiated).async {
            self.charge(name: self.name, cc: self.ccNumber, expMon: self.expMonth, expYear: self.expYear, cvc: self.cvc) { success, message in
                
                print("nice success \(success)")
                print("nice message \(String(describing: message))")
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getStyle() {
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.image = UIImage(named: "helpingHand")
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.view.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        centerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.55).isActive = true
        centerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        centerView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        nameLabel.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        nameLabel.textAlignment = .center
        nameLabel.text = name
        
        centerView.addSubview(ccLabel)
        ccLabel.translatesAutoresizingMaskIntoConstraints = false
        ccLabel.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        ccLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        ccLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        ccLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        ccLabel.textAlignment = .center
        let ccString = String(ccNumber.suffix(4))
        ccLabel.text = "CC Number: xxxx-" + ccString
        
        centerView.addSubview(expLabel)
        expLabel.translatesAutoresizingMaskIntoConstraints = false
        expLabel.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        expLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        expLabel.topAnchor.constraint(equalTo: ccLabel.bottomAnchor, constant: 20).isActive = true
        expLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        expLabel.textAlignment = .center
        var expString = "Expiration: "
        expString.append(expMonth)
        expString.append(" / ")
        expString.append(expYear)
        expLabel.text = expString
        
        centerView.addSubview(cvcLabel)
        cvcLabel.translatesAutoresizingMaskIntoConstraints = false
        cvcLabel.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        cvcLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        cvcLabel.topAnchor.constraint(equalTo: expLabel.bottomAnchor, constant: 20).isActive = true
        cvcLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        cvcLabel.textAlignment = .center
        cvcLabel.text = "CVC: xxx"
        
        centerView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        typeLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        typeLabel.topAnchor.constraint(equalTo: cvcLabel.bottomAnchor, constant: 20).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        typeLabel.textAlignment = .center
        typeLabel.text = "Type: " + cardType
        
        centerView.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        emailLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        emailLabel.textAlignment = .center
        emailLabel.text = email

        centerView.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.widthAnchor.constraint(equalTo: centerView.widthAnchor).isActive = true
        confirmButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        confirmButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20).isActive = true
        confirmButton.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        confirmButton.backgroundColor = UIColor.red
        confirmButton.layer.cornerRadius = 15
        confirmButton.setTitle("Confirm Your Donation", for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmed), for: .touchUpInside)
        
    }
    
    @objc func confirmed() {
        //delay
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.centerView.removeFromSuperview()
            self.view.addSubview(self.successImageView)
            self.successImageView.translatesAutoresizingMaskIntoConstraints = false
            self.successImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            self.successImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            self.successImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.successImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
            self.successImageView.image = UIImage(named: "successCheck")
            self.successImageView.contentMode = UIViewContentMode.scaleAspectFit
            
            self.view.addSubview(self.successLabel)
            self.successLabel.translatesAutoresizingMaskIntoConstraints = false
            self.successLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
            self.successLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
            self.successLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.successLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50).isActive = true
            self.successLabel.text = "Success! Thank you for your donation"
            self.successLabel.textAlignment = .center
            self.successLabel.textColor = UIColor.gray
            self.successLabel.font = UIFont(name: "Times", size: 14)
        }
        
        //background task
        DispatchQueue.global(qos: .userInitiated).async {
            
             self.charge(name: self.name, cc: self.ccNumber, expMon: self.expMonth, expYear: self.expYear, cvc: self.cvc) { success, message in
                
                 //return data
                
            }
            
        }
    }
   
    private func clientURLRequest(path: String, params: [String: AnyObject]? = nil) -> NSMutableURLRequest {
        var request = NSMutableURLRequest()
        if let url = URL(string: ("http://api.website.com/" + path)) {
            request = NSMutableURLRequest(url: url)
        }
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                paramString += "\(String(describing: escapedKey))=\(String(describing: escapedValue))&"
            }
            
            request.setValue("application/www-urlencoded-charge", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        return request
    }
    
    func charge(name: String, cc: String, expMon: String, expYear: String, cvc: String, completion: @escaping (_ success: Bool, _ message: String?) -> ()) {
        let chargeObject = ["name": name, "cc": cc, "expMon": expMon, "expYear": expYear, "cvc": cvc]
        
        httpClient.post(request: clientURLRequest(path: "auth/charge/local", params: chargeObject as [String : AnyObject]), callback: { (success, response) in
           // return data
        })
        
    }
        
    
    
}
