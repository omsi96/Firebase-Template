//
//  ItemsList.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/9/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct ItemsList: View {
    @State var items: [Item] = []
    var body: some View {
        NavigationView {
            List(items, id: \.self){ (item: Item) in
                Text(item.name)
            }
            .navigationBarTitle("List of Item")
            .onAppear(perform: getListOfItems)
        }
    }
    
    func getListOfItems()
    {
        Networking.getListOf(COLLECTION_NAME: "omar") { (items: [Item]) in
            self.items = items
        }
    }
}

struct ItemsList_Previews: PreviewProvider {
    static var previews: some View {
        ItemsList()
    }
}
