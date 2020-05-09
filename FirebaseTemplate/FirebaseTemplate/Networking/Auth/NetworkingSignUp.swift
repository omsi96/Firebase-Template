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
        
        let userData = ["imgeURL" : "usersImages/\(uid).jpg"
        ]
        db.collection("users").document(uid).updateData(["imageURL" : userData] )
    }
    
    
    /// **This sign up funciton will work on all Users **
    static func signUp<USER: User>(user: USER, password: String, success: ((String)->Void)? = nil, fail: (()->Void)? = nil)
    {
        print("👱🏻‍♂️ Creating user ...")
        Auth.auth().createUser(withEmail: user.email, password: password) { (result, error) in
            guard (error == nil) else {
                DispatchQueue.main.async{
                    fail?()
                }
                return
            }
            guard let result = result else {return}
            let uid = result.user.uid
            var user = user
            user.uid = uid
            DispatchQueue.main.async {
                print("👱🏻‍♂️ User has been added to firebase successfully ...")
                print("👱🏻‍♂️ User type is: \(user.userType  == "" ? "NOT SET" : user.userType)")
                user.userType = user.userType == "" ? "users" : user.userType
                print("👱🏻‍♂️ User will be added to collection: \(user.userType)")


                Networking.createItem(user, inCollection: user.userType, withDocumentId: user.uid!) {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: "signedIn")
                        UserDefaults.standard.set(user.userType, forKey: "userType")
                        UserDefaults.standard.set(user.uid, forKey: "uid")
                        success?(uid)
                    }
                }
            }
        }
    }
}

