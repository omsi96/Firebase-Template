//
//  iPhoneCreater.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct iPhoneCreater: View {
    @State var type: String = ""
    @State var model: String = ""
    @State var price: String = ""
    @State var iPhoneCreated = false
    @State var iPhoneCreatedFailed = false
    var body: some View {
        VStack{
            TextField("type", text: $type)
            TextField("model year", text: $model)
            TextField("price", text: $price)
            Button("Register iPhone", action: createIphone)
                .alert(isPresented: $iPhoneCreated, content: iPhoneCreatedAlert)
        }
        //.alert(isPresented: $iPhoneCreatedFailed, content: iPhoneCreatedFailedAlert)
        
    }
    
    func createIphone()
    {
        let iphone = iPhone(type: type, modelYear: Int(model)!, price: Double(price)!)
        Networking.createItem(iphone, inCollection: "iphones", withDocumentId: iphone.type, success: {
            self.iPhoneCreated = true
        }) { error in
            self.iPhoneCreatedFailed = true
        }
    }
    
    func iPhoneCreatedAlert() -> Alert
    {
        Alert(title: Text("Horray!🤘🏻"), message: Text("iPhone has been created successfully!"), dismissButton: .default(Text("Done")))
    }
    func iPhoneCreatedFailedAlert() -> Alert
    {
        Alert(title: Text("Opps!😅"), message: Text("iPhone couldn't be created"), dismissButton: .default(Text("Done")))
    }
}

struct iPhoneCreater_Previews: PreviewProvider {
    static var previews: some View {
        iPhoneCreater()
    }
}
