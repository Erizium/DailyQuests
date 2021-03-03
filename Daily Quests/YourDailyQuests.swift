//
//  YourDailyQuests.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

//sortera DisclosureGroup efter inläggningsdatum, lägga till datum i CoreData och gå efter det i "sortDescriptors: []".

struct YourDailyQuests: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Daily.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Daily.date, ascending: false)])
        var dailys: FetchedResults<Daily>
    @FetchRequest(entity: TomorrowDaily.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Daily.date, ascending: false)])
        var tomorrowDaily: FetchedResults<TomorrowDaily>
    
    @State private var isExpanded = false
    @State private var isExpanded2 = false
    @State private var addNewQuest = false
    @State private var addNextQuest = false
    @State private var showAlert = false
    @State private var completedDailyQuests = UserDefaults.standard.integer(forKey: "CompletedDaily")
    
    @State private var timeRemaining = 24*60*60
    @State private var doneText = "Uncompleted"
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
    
    var body: some View {

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    HStack {
                        Spacer()
                        Text("Daily Quests").font(.largeTitle)
                        Image("QuestLetter")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Spacer()
                    }
                    Spacer().frame(height: 10)
                    HStack {
                        Spacer()
                        Text("Until reset:").font(.title3)
                        Text("\(timeString(time: timeRemaining))")
                            .padding()
                            .font(.title2)
                            .onAppear() {
                                timeUntilNextDay()
                            }
                            .onReceive(timer){ _ in
                                
                                timeUntilNextDay()
                                
                            }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("\(doneText)")
                        Spacer()
                    }
                    Spacer().frame(height: 20)
                        
                    DisclosureGroup("Todays Quests       \(completedDailyQuests)/\(dailys.count)", isExpanded: $isExpanded) {
                        ScrollView {
                            VStack {
                                Spacer()
                                Text("Swipe left or right to delete a quest").font(.system(size: 13))
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
                                            
                                            if completedDailyQuests == dailys.count {
                                                doneText = "Completed with \(timeString(time: timeRemaining)) left"
                                                
                                                let timeLeft = String(timeRemaining)
                                                UserDefaults.standard.set(timeLeft, forKey: "timeLeft")
                                                //self.timer.upstream.connect().cancel()
                                            } else {
                                                doneText = "Uncompleted"
                                            }
                                            
                                        }) {
                                            Image(systemName: daily.done == true ?
                                                    "square.dashed.inset.fill" : "square.dashed")
                                        }
                                        Spacer()
                                        Text(daily.name ?? "Unknown")
                                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                                    .onEnded { value in
                                                        let horizontalAmount = value.translation.width as CGFloat
                                                        let verticalAmount = value.translation.height as CGFloat
                                                        
                                                        if abs(horizontalAmount) > abs(verticalAmount) {
                                                            print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                                                        } else {
                                                            print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                                        }
                                                        if daily.done == true {
                                                            completedDailyQuests -= 1
                                                        }
                                                        viewContext.delete(daily)
                                                        try? viewContext.save()
                                                    })
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
                    .offset(x: 250, y: 0)
                    
                    Spacer().frame(height: 20)
                    
                    DisclosureGroup("Tomorrows Quests", isExpanded: $isExpanded2) {
                        ScrollView {
                            VStack {
                                Spacer()
                                ForEach(tomorrowDaily) { tomorrowDaily in
                                    HStack {
                                        Button(action: {
                                            tomorrowDaily.done.toggle()
                                        }){
                                            Image(systemName:  tomorrowDaily.done == true ? "square.dashed.inset.fill" : "square.dashed")
                                        }
                                        Spacer()
                                        Text(tomorrowDaily.name ?? "Unknown")
                                            .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
                                                        .onEnded { value in
                                                            let horizontalAmount = value.translation.width as CGFloat
                                                            let verticalAmount = value.translation.height as CGFloat
                                                            
                                                            if abs(horizontalAmount) > abs(verticalAmount) {
                                                                print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                                                            } else {
                                                                print(verticalAmount < 0 ? "up swipe" : "down swipe")
                                                            }
                                                            viewContext.delete(tomorrowDaily)
                                                            try? viewContext.save()
                                                        })
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
                        
                        Text("Add Quest")
                    }.sheet(isPresented: $addNextQuest) {
                        AddNextQuest()
                    }.padding()
                    .offset(x: 250)
                    
                }.padding()
            }
    }
    
    func timeString(time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format: "%2i:%2i:%2i", hours, minutes, seconds)
    }
    
    func timeUntilNextDay() {
        
        let startOfNextDay = Calendar.current.nextDate(after: Date(), matching: DateComponents(hour: 0, minute: 0), matchingPolicy: .nextTimePreservingSmallerComponents)!
        
        let untilNextDay = startOfNextDay.timeIntervalSince(Date())
        
        timeRemaining = Int(untilNextDay)
    }
    
//    func doneTextTrue() {
//
//        if completedDailyQuests == dailys.count {
//            doneText = "Completed with \("timeLeft") left"
//        }
//    }
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
