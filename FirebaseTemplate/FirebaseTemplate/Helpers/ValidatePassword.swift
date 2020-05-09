//
//  ValidatePassword.swift
//  PreggNet
//
//  Created by ADF on 10/14/19.
//  Copyright © 2019 ADF. All rights reserved.
//

import Foundation
class Password{
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        return password.count >= 8
//
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
    }
    
    static func isPasswordMatch(_ password : String,  secondPassword: String) -> Bool {
           if password == secondPassword
           {
            return true
           }
        return false
       
}

}
