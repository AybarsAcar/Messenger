//
//  ConversationsViewController.swift
//  Messenger
//
//  Created by Aybars Acar on 20/3/2022.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .red
  
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    validateAuth()
  }
  
  private func validateAuth() {
    
    if FirebaseAuth.Auth.auth().currentUser == nil {
      // send to the login view controller
      let vc = LoginViewController()
      
      let nav = UINavigationController(rootViewController: vc)
      nav.modalPresentationStyle = .fullScreen
      
      present(nav, animated: false)
    }
  }
  
}
