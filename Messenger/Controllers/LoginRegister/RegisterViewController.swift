//
//  RegisterViewController.swift
//  Messenger
//
//  Created by Aybars Acar on 20/3/2022.
//

import UIKit

class RegisterViewController: UIViewController {
  
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
  
  private let firstNameField: UITextField = {
    let field = UITextField()
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.returnKeyType = .continue
    
    field.layer.cornerRadius = 12
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.placeholder = "First Name..."
    
    // add a buffer inside the field
    field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
    field.leftViewMode = .always
    field.backgroundColor = .white
    
    return field
  }()
  
  private let lastNameField: UITextField = {
    let field = UITextField()
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.returnKeyType = .continue
    
    field.layer.cornerRadius = 12
    field.layer.borderWidth = 1
    field.layer.borderColor = UIColor.lightGray.cgColor
    field.placeholder = "Last Name..."
    
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
  
  private let registerButton: UIButton = {
    let button = UIButton()
    button.setTitle("Register", for: .normal)
    button.backgroundColor = .systemGreen
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 12
    button.layer.masksToBounds = true
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    return button
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "person")
    imageView.tintColor = .gray
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Log In"
    view.backgroundColor = .white
    
    // setup buttons and actions
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
    registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    
    // set up delegates
    emailField.delegate = self
    passwordField.delegate = self
    
    // Add subviews
    view.addSubview(scrollView)
    
    scrollView.addSubview(imageView)
    scrollView.addSubview(emailField)
    scrollView.addSubview(passwordField)
    scrollView.addSubview(registerButton)
    scrollView.addSubview(firstNameField)
    scrollView.addSubview(lastNameField)
    
    // image view isUserInteractionEnabled is required to set a tap gesture on the image
    imageView.isUserInteractionEnabled = true
    scrollView.isUserInteractionEnabled = true
    
    // add a gesture recogniser to the image view - add an onTapGesture
    let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePicture))
    gesture.numberOfTouchesRequired = 1
    gesture.numberOfTapsRequired = 1
    imageView.addGestureRecognizer(gesture)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // layout scrollview
    scrollView.frame = view.bounds
    
    // layout the logo
    let size = scrollView.width / 3
    imageView.frame = CGRect(x: (scrollView.width - size) / 2, y: 20, width: size, height: size)
    
    // layout email field
    emailField.frame = CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
    
    // layout first name field
    firstNameField.frame = CGRect(x: 30, y: emailField.bottom + 10, width: scrollView.width - 60, height: 52)
    
    // layout last name field
    lastNameField.frame = CGRect(x: 30, y: firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
    
    // layout password field
    passwordField.frame = CGRect(x: 30, y: lastNameField.bottom + 10, width: scrollView.width - 60, height: 52)
    
    // layout login button
    registerButton.frame = CGRect(x: 30, y: passwordField.bottom + 10, width: scrollView.width - 60, height: 52)
    
  }
  
  @objc private func didTapChangeProfilePicture() {
    print("Change profile picture")
  }
  
  @objc private func registerButtonTapped() {
    
    // dismiss the keyboard
    emailField.resignFirstResponder()
    passwordField.resignFirstResponder()
    firstNameField.resignFirstResponder()
    lastNameField.resignFirstResponder()
    
    guard let email = emailField.text, let password = passwordField.text, let firstName = firstNameField.text, let lastName = lastNameField.text,
            !email.isEmpty, !password.isEmpty, password.count >= 6, !firstName.isEmpty, !lastName.isEmpty else {
      alertUserLoginError()
      return
    }
    
    // Firebase login here
  }
  
  /// shows user an alert
  private func alertUserLoginError() {
    let alert = UIAlertController(title: "Oops...", message: "Please enter all information to create a new account.", preferredStyle: .alert)
    
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
extension RegisterViewController: UITextFieldDelegate {
  
  /// called when user hits keyboard return button
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    // navigate to password field when return hit
    if textField == emailField {
      firstNameField.becomeFirstResponder()
    }
    else if textField == firstNameField {
      lastNameField.becomeFirstResponder()
    }
    else if textField == passwordField {
      passwordField.becomeFirstResponder()
    }
    // login flow executes when the user taps in the return key
    // when passwordField is focused
    else if textField == passwordField {
      registerButtonTapped()
    }
    
    return true
  }
}
