//
//  HomeViewController.swift
//  budgetx
//
//  Created by Kabylake on 12/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        lblUsername.text = "Hai, \(Auth.shared.getUsername()!)"
    }
    

    @IBAction func btnLogout_onClick(_ sender: Any) {
        let LoginScreen = storyboard?.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
        
        let nav = navigationController
        
        let alertController = UIAlertController(title: "Konfirmasi", message: "Apakah Anda ingin keluar?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            Auth.shared.logout()
            nav?.pushViewController(LoginScreen, animated: false)
        }
        
        let cancelAction = UIAlertAction(title: "Batal", style: .default) { (_) in
            print("Canceled")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
