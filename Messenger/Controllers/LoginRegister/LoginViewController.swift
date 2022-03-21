//
//  LoginViewController.swift
//  Messenger
//
//  Created by Aybars Acar on 20/3/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
  
  private let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.clipsToBounds = true
    sv.showsVerticalScrollIndicator = false
    return sv
  }()
  
  private let emailField: UITextField = {
    let field = UITextField()
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.returnKeyType = .continue
    
    field.layer.cornerRadius = 12
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.placeholder = "Email Address..."
    
    // add a buffer inside the field
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    field.leftViewMode = .always
    field.backgroundColor = .white
    
    return field
  }()
  
  private let passwordField: UITextField = {
    let field = UITextField()
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.returnKeyType = .done
    
    field.layer.cornerRadius = 12
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.placeholder = "Password..."
    
    field.isSecureTextEntry = true
    
    // add a buffer inside the field
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    field.leftViewMode = .always
    field.backgroundColor = .white
    
    return field
  }()
  
  private let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Login", for: .normal)
    button.backgroundColor = .link
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 12
    button.layer.masksToBounds = true
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    return button
  }()
  
  private let logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "logo")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Log In"
    view.backgroundColor = .white
    
    // setup buttons and actions
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
    loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    
    // set up delegates
    emailField.delegate = self
    passwordField.delegate = self
    
    // Add subviews
    view.addSubview(scrollView)
    
    scrollView.addSubview(logoImageView)
    scrollView.addSubview(emailField)
    scrollView.addSubview(passwordField)
    scrollView.addSubview(loginButton)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // layout scrollview
    scrollView.frame = view.bounds
    
    // layout the logo
    let size = scrollView.width / 3
    logoImageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
    
    // layout email field
    emailField.frame = CGRect(x: 30, y: logoImageView.bottom + 10, width: scrollView.width - 60, height: 52)
    
    // layout password field
    passwordField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width - 60, height: 52)
    
    // layout login button
    loginButton.frame = CGRect(x: 30, y: passwordField.bottom + 10, width: scrollView.width - 60, height: 52)

  }
  
  @objc private func loginButtonTapped() {
    
    // dismiss the keyboard
    emailField.resignFirstResponder()
    passwordField.resignFirstResponder()
    
    guard let email = emailField.text, let password = passwordField.text,
          !email.isEmpty, !password.isEmpty, password.count >= 6 else {
      alertUserLoginError()
      return
    }
    
    // Firebase login here
    FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
      guard let self = self else { return }
      guard let result = authResult, error == nil else {
        print("Failed the log in user with email: \(email)")
        print(error!)
        return
      }
      
      let user = result.user
      print(user)
      
      self.navigationController?.dismiss(animated: true, completion: nil)
    }
  }
  
  /// shows user an alert
  private func alertUserLoginError() {
    let alert = UIAlertController(title: "Oops...", message: "Please enter all information to login", preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
    
    present(alert, animated: true)
  }
  
  @objc private func didTapRegister() {
    let vc = RegisterViewController()
    vc.title = "Create Account"
    navigationController?.pushViewController(vc, animated: true)
  }
}


// MARK: - Text field delegate methods
extension LoginViewController: UITextFieldDelegate {
  
  /// called when user hits keyboard return button
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    // navigate to password field when return hit
    if textField == emailField {
      passwordField.becomeFirstResponder()
    }
    // login flow executes when the user taps in the return key
    // when passwordField is focused
    else if textField == passwordField {
      loginButtonTapped()
    }
    
    return true
  }
}
