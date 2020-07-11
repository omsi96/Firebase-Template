//
//  Authentication.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct SignUp: View {
    @State var user: OmarUser = OmarUser()
    @State var password: String = ""
    @State var uid: String = ""
    
    @State var signedUp = false
    @State var signedUpFailed = false
    var body: some View {
        NavigationView {
            VStack{
                TextField("first name", text: $user.firstname)
                    .padding()
                
                TextField("last name", text: $user.lastname)
                    .padding()
                
                TextField("email", text: $user.email)
                    .padding()
                
                TextField("phone number", text: $user.phoneNumber)
                    .padding()
                
                SecureField("password", text: $password)
                    .padding()
                
                Button("Sign up", action: signUp)
                
                Spacer()
            }
            .alert(isPresented: $signedUp, content: signUpAlert)
            .padding()
            .navigationBarTitle("Sign up")
        }.alert(isPresented: $signedUpFailed, content: signUpFailedAlert)

    }
    
    func signUp(){
        Networking.signUp(user: user, password: password, success: { uid in
            self.uid = uid
            self.signedUp = true
        }) {
            self.signedUpFailed = true
        }
    }
    
    func signUpAlert() -> Alert{
        Alert(title: Text("Signed up!"), message: Text("You have signed up successfully with user id \(uid)"), dismissButton: .default(Text("Done"), action: {
            //
        }))
    }

    func signUpFailedAlert() -> Alert{
        Alert(title: Text("Error!"), message: Text("Couldn't sign up with email \(self.user.email)."), dismissButton: .default(Text("Done"), action: {
            //
        }))
    }
    
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

