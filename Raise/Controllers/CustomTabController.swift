//
//  CustomTabController.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import UIKit

class CustomTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.isTranslucent = true
        self.view.tintColor = UIColor.black
        
       /* let detectionController = DetectionController()
        let navigationController = UINavigationController(rootViewController: detectionController)
        navigationController.navigationBar.tintColor = UIColor.black
        navigationController.tabBarItem.image = UIImage(named: "camera")*/
        
        let manualController = AmountController()
        let manualNavigationController = UINavigationController(rootViewController: manualController)
        manualNavigationController.navigationBar.tintColor = UIColor.black
        manualNavigationController.tabBarItem.image = UIImage(named: "home-icon")
        
        viewControllers = [manualNavigationController]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
