//
//  NewTaskView.swift
//  FirebaseTemplate
//
//  Created by Omar Alibrahim on 5/11/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import SwiftUI

struct NewTaskView: View {
    @State var newTaskPopUpShown = false
    @State var cardOffsetY: CGFloat = 1024
    
    
    var body: some View {
        ZStack{
            NewTaskPopUpView()
                .padding(-20)
                .offset(x: 0, y: newTaskPopUpShown ? 300 : cardOffsetY)
                .animation(.interactiveSpring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.2))
                .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global))
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    AddButton(tapped: $newTaskPopUpShown)
                    Spacer()
                    
                }
            }
            
        }.background(backgroundChooser())
    }
    
    func backgroundChooser() -> some View{
        var bg = BG(color: #colorLiteral(red: 0.9803921569, green: 0.9529411765, blue: 0.9411764706, alpha: 1)).edgesIgnoringSafeArea(.all)
        if !newTaskPopUpShown{
            bg = BG(color: #colorLiteral(red: 0.9803921569, green: 0.9529411765, blue: 0.9411764706, alpha: 1)).edgesIgnoringSafeArea(.all)
        }else {
            bg = BG(color: #colorLiteral(red: 1, green: 0.8941176471, blue: 0.831372549, alpha: 1)).edgesIgnoringSafeArea(.all)
        }
        return bg
    }

}

struct TagItem: Hashable{
    var title: String
    var color: String
    var isAdd: Bool
    
    static var all: [TagItem] {
        [
           TagItem(title: "Prayer", color: "pinky", isAdd: false),
           TagItem(title: "Fasting", color: "pinky", isAdd: false),
           TagItem(title: "add", color: "gray", isAdd: true),
        ]
    }
}
struct NewTaskPopUpView: View{
    @State var taskTitle: String = ""
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 60)
                .foregroundColor(.white)
//                .shadow(radius: 12)
            VStack{
                Text("New Task")
                    .font(.custom("Avenir Next Demi Bold", size: 40))
                    .bold()
                    .padding()
                TextField("What do you want to do?", text: $taskTitle)
                    .font(.custom("Avenir Next Regular", size: 20))
                    .multilineTextAlignment(.center)
                    .lineLimit(0)
                TagsScroll().padding(.horizontal, 50)
                Spacer()
            }
            
        }
    }
}

struct BG: View{
    @State var color = #colorLiteral(red: 0.9803921569, green: 0.9529411765, blue: 0.9411764706, alpha: 1)
    var body: some View{
        Color(color)
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NewTaskView()
            NewTaskPopUpView()
            TagsScroll()
        }
    }
}

struct AddButton: View {
    @State var buttonWidth: CGFloat = 60
    @Binding var tapped: Bool
    var body: some View {
        ZStack(alignment: tapped ? .leading : .center){
            Capsule()
                .foregroundColor(Color(#colorLiteral(red: 0.2588235294, green: 0.3176470588, blue: 0.5843137255, alpha: 1)))
                .frame(width: buttonWidth, height: 60)
                .padding()
            HStack{
                Image(systemName: "plus")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                
                if tapped{
                    Text("Add new item")
                        .font(.custom("Avenir Next Demi Bold", size: 20))
                        .animation(.linear)
                    
                }
            }
            .foregroundColor(.white)
            .padding(.leading, tapped ? 60 : 0)
            
        }
        .onTapGesture(perform: newItem)
            
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.3))
        
    }
    
    func newItem(){
        tapped.toggle()
        buttonWidth = tapped ? 400 : 60
    }
}

struct TagsScroll: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(TagItem.all, id: \.self) { item in
                    Text(item.title)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(Color(item.color))
                        .clipShape(RoundedRectangle(cornerRadius: item.isAdd ? 12 : 7))
                        .padding(.horizontal, 2)
                        .foregroundColor(Color(#colorLiteral(red: 0.1777162254, green: 0.1777162254, blue: 0.1777162254, alpha: 1)))
                        .blendMode(.colorBurn)
                        
                }
            }
        }
    }
}
