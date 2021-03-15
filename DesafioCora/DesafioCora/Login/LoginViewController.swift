//
//  ViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit
import Firebase

class LoginViewController: BaseViewController {

    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        initializeHideKeyboard()
    }

    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(loginView)
        self.loginView.loginAction = loginPressed
        self.loginView.signUpAction = signUpPressed
    }
    
    func loginPressed() {
        self.showLoadingAnimation()
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextFied.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                self.hiddenLoadingAnimation()
                self.showAlert(alertText: "Error", alertMessage: "\(err.localizedDescription)")
            } else {
                let goToOrderListVc = OrderListViewController()
                goToOrderListVc.modalPresentationStyle = .fullScreen
                self.present(goToOrderListVc, animated: true, completion: nil)
                self.hiddenLoadingAnimation()
            }
        }
    }
    
    func signUpPressed() {
        let goToSignUpScreen = SignUpViewController()
        let navVC = UINavigationController(rootViewController: goToSignUpScreen)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        
    }
}

extension LoginViewController {
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
}
