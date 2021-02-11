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
    
    @State private var addNewQuest = false
    
    @State private var isExpanded = false
    @State private var isExpanded2 = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Daily Quests").font(.largeTitle)
                Spacer().frame(height: 50)
                DisclosureGroup("Todays Quests", isExpanded: $isExpanded) {
                    ScrollView {
                        VStack {
                            //if logged in, foreach sync form firebase
                            //else, ForEach in coredata
                            
                            ForEach(dailys) { daily in
                                Text(daily.name ?? "Unknown")
                                    .onTapGesture {
                                    viewContext.delete(daily)
                                        
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
                
                DisclosureGroup("Tomorrows Quests", isExpanded: $isExpanded2) {
                    ScrollView {
                        VStack {
                            Text("Running")
                            Text("Situps")
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
