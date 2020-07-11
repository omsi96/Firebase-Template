//
//  SignUp.swift
//  495-project-2
//
//  Created by Omar Alibrahim on 5/8/20.
//  Copyright © 2020 ADF. All rights reserved.
//

import Foundation
import Firebase

extension Networking{
    
    
    static func setUserImage(uid: String)
    {
        // user was created successfully, now store the first name and last name
        let db = Firestore.firestore()
        
        let userData = ["imgeURL" : "usersImages/\(uid).jpg"]
        db.collection("users").document(uid).updateData(["imageURL" : userData] )
    }
    
    
    /// **This sign up funciton will work on all Users **
    static func signUp(user: User, password: String, success: ((String)->Void)? = nil, fail: (()->Void)? = nil)
    {
        print("👱🏻‍♂️ Creating user ...")
        Auth.auth().createUser(withEmail: user.email, password: password) { (result, error) in
            guard (error == nil) else {
                DispatchQueue.main.async{
                    fail?()
                }
                return
            }
            print("👱🏻‍♂️ User has been created successfully ...")
            guard let result = result else {return}
            let uid = result.user.uid
            DispatchQueue.main.async {
                print("👱🏻‍♂️ User has been added to DATABASE successfully ...")
                Networking.createItem(user, inCollection: "users", withDocumentId: uid) {
                    DispatchQueue.main.async {
                        success?(uid)
                    }
                }
            }
            
        }
    }
}

