//
//  AuthManagers.swift
//  InstaClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 12.11.2024.
//

import FirebaseAuth


public class AuthManager {
    public static let shared = AuthManager()
       
    
    //MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        /*
         - Check if username is available
         - Check if email is available
         */
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create Account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil, error == nil else {
                        //Firebase could not creaet account
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            //Failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                //Either email or username does exists
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            print(username)
        }
        
        
    }
    
}
