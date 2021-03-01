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
    @FetchRequest(entity: NextWeek.entity(), sortDescriptors: [])
        var nextWeek: FetchedResults<NextWeek>
    
    @State private var isExpanded = false
    @State private var isExpanded2 = false
    @State private var addNewQuest = false
    @State private var addNextQuest = false
    @State private var completedWeeklyQuests = UserDefaults.standard.integer(forKey: "CompletedWeekly")
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Weekly Quests").font(.largeTitle)
                Spacer().frame(height: 50)
                DisclosureGroup("This weeks quests      \(completedWeeklyQuests)/\(weeklys.count)", isExpanded: $isExpanded) {
                    ScrollView {
                        VStack {
                            ForEach(weeklys) { weekly in
                                
                                HStack {
                                    Button(action: {
                                        weekly.done.toggle()
                                        
                                        if weekly.done == true {
                                            completedWeeklyQuests += 1
                                            print(completedWeeklyQuests)
                                        } else {
                                            completedWeeklyQuests -= 1
                                            print(completedWeeklyQuests)
                                        }
                                        UserDefaults.standard.set(completedWeeklyQuests, forKey: "CompletedWeekly")
                                        
                                        do {
                                            try viewContext.save()
                                        } catch {
                                            print("Error weekly")
                                        }
                                    }) {
                                        Image(systemName: weekly.done == true ? "square.dashed.inset.fill" : "square.dashed")
                                    }
                                    Spacer()
                                    Text(weekly.name ?? "Unkown")
                                        .onTapGesture {
                                            viewContext.delete(weekly)
                                            
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
                    self.addNewQuest = true
                }){
                    Text("Add quest")
                }.sheet(isPresented: $addNewQuest) {
                    AddQuest()
                }.padding()
                .offset(x: 250)
        
                Spacer().frame(height: 20)
                
                DisclosureGroup("Next Weeks Quests", isExpanded: $isExpanded2) {
                    ScrollView {
                        VStack {
                            ForEach(nextWeek) { nextWeek in
                                
                                HStack {
                                    Button(action: {
                                        nextWeek.done.toggle()
                                     
                                    }) {
                                        Image(systemName: nextWeek.done == true ? "square.dashed.inset.fill" : "square.dashed")
                                    }
                                    Spacer()
                                    Text(nextWeek.name ?? "Unkown")
                                        .onTapGesture {
                                            viewContext.delete(nextWeek)
                                            
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
                    self.addNextQuest = true
                }){
                 Text("Add quest")
                }.sheet(isPresented: $addNextQuest) {
                    AddNextQuest()
                }.padding()
                .offset(x: 250)
                
            }.padding()
        }
    }
}

struct YourWeeklyQuests_Previews: PreviewProvider {
    static var previews: some View {
        YourWeeklyQuests()
    }
}
