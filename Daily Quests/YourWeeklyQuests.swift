//
//  YourWeeklyQuests.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

struct YourWeeklyQuests: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Weekly.entity(), sortDescriptors: [])
        var weeklys: FetchedResults<Weekly>
    
    @State private var addNewQuest = false
    
    @State private var isExpanded = false
    @State private var isExpanded2 = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Weekly Quests").font(.largeTitle)
                Spacer().frame(height: 50)
                DisclosureGroup("This weeks quests", isExpanded: $isExpanded) {
                    ScrollView {
                        VStack {
                            ForEach(weeklys) { weekly in
                                Text(weekly.name ?? "Unkown")
                                    .onTapGesture {
                                        viewContext.delete(weekly)
                                        
                                        try? viewContext.save()
                                    }
                            }
                            
                        }
                    }
                }.accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 7, x: 0, y: 10)
                
                Button(action: {
                    self.addNewQuest.toggle()
                }){
                    Text("Add quest")
                }.sheet(isPresented: $addNewQuest) {
                    AddQuest()
                }.padding()
                .offset(x: 250, y: 0)
        
                Spacer().frame(height: 20)
                
                DisclosureGroup("Next Weeks Quests", isExpanded: $isExpanded2) {
                    ScrollView {
                        VStack {
                            Text("Nothing")
                            Text("Here")
                            Text("Yet")
                        }
                    }
                }.accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 7, x: 0, y: 10)
            }.padding()
        }
    }
}

struct YourWeeklyQuests_Previews: PreviewProvider {
    static var previews: some View {
        YourWeeklyQuests()
    }
}
