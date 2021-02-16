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
    @State private var addNewQuest = false
    @State private var completedDailyQuests = UserDefaults.standard.integer(forKey: "CompletedDaily")
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Daily Quests").font(.largeTitle)
                Spacer().frame(height: 50)
                
                DisclosureGroup("Todays Quests       \(completedDailyQuests)/\(dailys.count)", isExpanded: $isExpanded) {
                    ScrollView {
                        
                        VStack {
                            Spacer()
                            ForEach(dailys) { daily in
                                HStack {
                                    Button(action: {
                                        daily.done.toggle()
                                        
                                        if daily.done == true {
                                            completedDailyQuests += 1
                                            
                                        } else {
                                           completedDailyQuests -= 1
                                            
                                        }
                                        
                                        
                                        UserDefaults.standard.set(completedDailyQuests, forKey: "CompletedDaily")
                                       
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            print("Error daily")
                                        }
                                    }) {
                                        Image(systemName: daily.done == true ?
                                                "square.dashed.inset.fill" : "square.dashed")
                                    }
                                    Spacer()
                                    Text(daily.name ?? "Unknown").onTapGesture {
                                        viewContext.delete(daily)
                                        try? viewContext.save()
                                    }
                                    Spacer()
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
        }
    }

}


struct YourDailyQuests_Previews: PreviewProvider {
    static var previews: some View {
        YourDailyQuests()
    }
}

//                                         .onTapGesture {
//                                            viewContext.delete(daily)
//                                            try? viewContext.save()
//                                        }


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
