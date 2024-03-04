import UIKit

class LoginViewController: UIViewController {
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        
        navigationItem.hidesBackButton = true
        txtPassword.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin_onClick(_ sender: Any) {
        guard let username = txtUsername.text, !username.isEmpty else {
            let alertController = UIAlertController(title: "Validasi", message: "Username tidak boleh kosong.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            let alertController = UIAlertController(title: "Validasi", message: "Password tidak boleh kosong.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        loadingIndicator.startAnimating()
        
        let NavScreen = storyboard?.instantiateViewController(withIdentifier: "NavScreen") as! NavViewController
        
        Auth.shared.login(username: username, password: password) { result in
            switch result {
            case .success:
                self.loadingIndicator.stopAnimating()
                
                self.navigationController?.pushViewController(NavScreen, animated: false)
            case .failure(let error):
                print("Login error: \(error)")
                
                self.loadingIndicator.stopAnimating()
                
                let alertController = UIAlertController(title: "Login Gagal", message: "Username/password salah.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
