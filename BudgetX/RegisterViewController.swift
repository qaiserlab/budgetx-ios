import UIKit

class RegisterViewController: UIViewController {
    
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        
        txtPassword.isSecureTextEntry = true
    }
    
    @IBAction func btnRegister_onClick(_ sender: Any) {
        guard let username = txtUsername.text, !username.isEmpty else {
            let alertController = UIAlertController(title: "Validasi", message: "Username tidak boleh kosong.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let email = txtEmail.text, !email.isEmpty else {
            let alertController = UIAlertController(title: "Validasi", message: "Email tidak boleh kosong.", preferredStyle: .alert)
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
        
        Auth.shared.register(username: username, email: email, password: password) { result in
            switch result {
            case .success:
                self.loadingIndicator.stopAnimating()
                
                let alertController = UIAlertController(title: "Registrasi Berhasil", message: "Registrasi user berhasil.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                let LoginScreen = self.storyboard?.instantiateViewController(withIdentifier: "LoginScreen") as! LoginViewController
                
                self.navigationController?.pushViewController(LoginScreen, animated: false)
            case .failure(let error):
                print("Register error: \(error)")
                
                self.loadingIndicator.stopAnimating()
                
                let alertController = UIAlertController(title: "Registrasi Gagal", message: "Register user gagal.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
}
