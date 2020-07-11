//
//  ThekrView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/12/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct Thekr: Codable{
    var title: String
    var counter: Int
}

struct ThekrView: View {
    @State var thekr: Thekr = Thekr(title: "سبحان الله", counter: 0)
    var body: some View {
        VStack{
            Text(thekr.title)
                .font(.largeTitle)
            Text("\(thekr.counter)")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.white)
                .frame(width: 100, height: 100, alignment:  .center)
                .background(Color.blue)
                .clipShape(Circle())
                .onTapGesture(perform: countThekr)
        }.onAppear {
            Networking.getSingleDocument("omarathkar/1") { (thekr: Thekr) in
                self.thekr = thekr
            }
        }
    }
    
    func countThekr()
    {
        thekr.counter += 1
        Networking.createItem(thekr, inCollection: "omarathkar", withDocumentId: "1") {
            print("Added to firease")
        }

    }
}

struct ThekrView_Previews: PreviewProvider {
    static var previews: some View {
        ThekrView()
    }
}
