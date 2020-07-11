//
//  SignIn.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct SignIn: View {
    @State var credentials = SignInCredentials(email: "", password: "")
    @State var signedIn = false
    @State var signedInFailed = false
    var body: some View {
        NavigationView {
            VStack{
                TextField("Email", text: $credentials.email)
                    .padding()
                
                SecureField("Password", text: $credentials.password)
                    .padding()
                
                Button("Sign In", action: signIn)
                
                Spacer()
            }
            .alert(isPresented: $signedIn, content: signInAlert)
            .padding()
            .navigationBarTitle("Sign In")
        }
        .alert(isPresented: $signedInFailed, content: signInFailedAlert)
        
    }
    
    func signIn(){
        Networking.signIn(user: credentials, collectionName: "users", success: { str in
            // successfully signed in
            self.signedIn = true
        }) {
            // fail
            self.signedInFailed = true
        }
    }

    func signInAlert() -> Alert{
        Alert(title: Text("Signed In 😍"), message: Text("You have signed in successfully with email \(self.credentials.email)."), dismissButton: .default(Text("Done")))
    }
    func signInFailedAlert() -> Alert{
        Alert(title: Text("Error!"), message: Text("Couldn't sign in with email \(self.credentials.email)."), dismissButton: .default(Text("Done")))
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
