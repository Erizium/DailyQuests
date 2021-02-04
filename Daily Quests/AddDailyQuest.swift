//
//  AddQuest.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI

struct AddDailyQuest: View {
    
    @State var addQuest: String = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer().frame(height: 100)
            Text("Add a new Daily Quest")
                .font(.largeTitle)
            
            Spacer().frame(height: 100)
            
            TextField("What's your new quest?", text: $addQuest)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.black)
            Spacer()
            
            NavigationLink(destination: YourDailyQuests()) {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.black)
            }
            
            
            Spacer()
        }.padding()
        
    }
}

struct AddDailyQuest_Previews: PreviewProvider {
    static var previews: some View {
        AddDailyQuest()
    }
}
