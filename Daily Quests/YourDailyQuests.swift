//
//  YourDailyQuests.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

struct YourDailyQuests: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Daily.entity(), sortDescriptors: []) var dailys: FetchedResults<Daily>
    
    @State private var isExpanded = false
    @State private var isExpanded2 = false
    
    let names = ["Tobias", "Toobias", "Tobbias"]
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Daily Quests").font(.largeTitle)
                Spacer().frame(height: 50)
                DisclosureGroup("Todays Quests", isExpanded: $isExpanded) {
                    ScrollView {
                        VStack {
                                //ForEach in database
                                ForEach(dailys) { daily in
                                    
                                    Text(daily.name ?? "Unknown").onTapGesture {
                                        viewContext.delete(daily)
                                        try? viewContext.save()
                                    }
                                    
                                }
                        }
                    }
                }.accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 7, x: 0, y: 10)
                
                Spacer().frame(height: 20)
                
                DisclosureGroup("Tomorrows Quests", isExpanded: $isExpanded2) {
                    ScrollView {
                        VStack {
                            Text("Running").padding()
                            Text("Situps")
                        }
                    }
                }.accentColor(.white)
                .font(.title2)
                .foregroundColor(.white)
                .padding(.all)
                .background(Color.blue)
                .cornerRadius(7)
                .shadow(color: .black, radius: 7, x: 0, y: 10)
            }.padding()
            
            NavigationLink(destination: AddDailyQuest()) {
                Text("Add new quest")
            }
            
//            Button("Add") {
//
//                let rName = names.randomElement()!
//
//
//                let daily = Daily(context: self.viewContext)
//                daily.name = "\(rName)"
//
//                try? self.viewContext.save()
//            }
        }
    }
}




struct YourDailyQuests_Previews: PreviewProvider {
    static var previews: some View {
        YourDailyQuests()
    }
}