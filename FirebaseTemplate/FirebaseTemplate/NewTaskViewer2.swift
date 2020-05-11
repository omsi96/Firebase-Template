//
//  NewTaskViewer2.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/11/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct NewTaskViewer2: View {
    var body: some View {
        VStack{
            PlusButton()
        }
    }
    

}

struct NewTaskViewer2_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskViewer2()
    }
}

struct PlusButton: View {
    @State var width: CGFloat = 60
    @State var tapped: Bool = false
    var body: some View {
        Button(action: addItem) {
            ZStack{
                Capsule().foregroundColor(Color("purple"))
                HStack{
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    if tapped{
                        Text("Add new item")
                            .font(.custom("Avenir Next Demi Bold", size: 18))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }.offset(x: tapped ? 20 : 0)
            }
            .frame(width: width, height: 60, alignment: .leading)
        }.animation(.interactiveSpring(response: 0.4, dampingFraction: 0.4, blendDuration: 0.5))
    }
    func addItem(){
        tapped.toggle()
        if tapped{
            width = 300
        }else{
            width = 60
        }
    }

}
