//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Aybars Acar on 21/3/2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
  
  static let shared = DatabaseManager()
  
  private let database: DatabaseReference
  
  private init() {
    self.database = Database.database().reference()
  }
  
}

// MARK: - Account Management
extension DatabaseManager {
  
  /// inserts new user to database
  /// make sure email of a user is unique
  func insertUser(with user: ChatAppUser) {
    database.child(user.emailAddress).setValue([
      "first_name": user.firstName,
      "last_name": user.lastName
    ])
  }
  
  /// returns true from the completion handler if a user exists with a given email
  /// observes an email value
  func userExists(withEmail email: String, completion: @escaping (_ exists: Bool) -> Void) {
    
    database.child(email).observeSingleEvent(of: .value) { snapshot in
      guard let _ = snapshot.value as? String else {
        completion(false)
        return
      }
      completion(true)
    }
  }
}


/// email of a user is unique
struct ChatAppUser {
  let firstName: String
  let lastName: String
  let emailAddress: String
//  let profilePictureURL: String
}
