//
//  ContentView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CreateItem()
                .tabItem {
                    VStack{
                        Image(systemName: "plus.circle.fill")
                        Text("Create Item")
                    }
            }.tag(1)
            
            ItemsList()
                .tabItem {
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("Items list")
                    }
            }.tag(2)
            
            SignIn()
                .tabItem {
                    VStack{
                        Image(systemName: "person.circle.fill")
                        Text("Sign in")
                    }
            }.tag(3)
            
            SignUp()
                .tabItem {
                    VStack{
                        Image(systemName: "person.crop.circle.badge.plus")
                        Text("Sign Up")
                    }
            }.tag(4)
            
            iPhoneCreater()
                .tabItem {
                    VStack{
                        Image(systemName: "phone.circle.fill")
                        Text("Create iPhone")
                    }
            }.tag(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
