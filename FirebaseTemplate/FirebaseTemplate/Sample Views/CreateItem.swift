//
//  ContentView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI


struct CreateItem: View {
    @State var name: String = ""
    @State var price: String = ""
    @State var itemCreated = false
    var body: some View {
        NavigationView {
            VStack{
                TextField("Name", text: $name)
                    .padding()
                TextField("price", text: $price)
                    .padding()
                Button("Create item", action: createItem)
                Spacer()
            }
            .padding()
            .navigationBarTitle("Create Item")
            .alert(isPresented: $itemCreated, content: createdItemAlert)
        }
    }
    
    
    
    func createItem()
    {
        let item = Item(name: self.name, price: Double(self.price)!)
        Networking.createItem(item, inCollection: "myItems") {
            self.itemCreated = true
        }
    }
    
    func createdItemAlert() -> Alert{
        Alert(title: Text("👏🏻"), message: Text("Item has been created successfully"), dismissButton: .default(Text("Done"), action: {
            //
        }))
    }
}

struct CreateItem_Previews: PreviewProvider {
    static var previews: some View {
        CreateItem()
    }
}
