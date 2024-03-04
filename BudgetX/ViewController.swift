//
//  ViewController.swift
//  budgetx
//
//  Created by Kabylake on 03/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let NavScreen = storyboard?.instantiateViewController(withIdentifier: "NavScreen") as! NavViewController
        
        let SliderScreen = storyboard?.instantiateViewController(withIdentifier: "SliderScreen") as! SliderViewController
        
        if (Auth.shared.isLoggedIn()) {
            navigationController?.pushViewController(NavScreen, animated: false)
        }
        else {
            navigationController?.pushViewController(SliderScreen, animated: false)
        }
        
    }


}

