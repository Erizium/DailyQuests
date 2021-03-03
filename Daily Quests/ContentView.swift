//
//  ContentView.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var showAlert = false
    var body: some View {
     
        NavigationView {
            VStack {
                Spacer().frame(height: 200)
                NavigationLink(destination: YourDailyQuests()) {
                    ZStack {

                        Image("QuestNote2")
                            .resizable()
                            .frame(width: 300, height: 150)
                            .cornerRadius(10)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 10,
                                    x: 0, y: 10)

                        Text("Daily\nQuests")
                            .foregroundColor(.black)
                            .offset(x: -70, y: -5)
                            .font(.title)
                    }
                }

                Spacer().frame(height: 50)
                
                NavigationLink(destination: YourWeeklyQuests()) {

                    ZStack {
                        Image("QuestNote2")
                            .resizable()
                            .frame(width: 300, height: 150)
                            .cornerRadius(7)
                            .shadow(color: .black, radius: 10,
                                    x: 0, y: 10)

                        Text("Weekly\nQuests")
                            .foregroundColor(.black)
                            .offset(x: -70, y: -5)
                            .font(.title)
                    }
                }
                HStack {
                    Spacer()
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .offset(y: 50)
                        .onTapGesture {
                            showAlert = true
                        }.alert(isPresented: $showAlert) {
                            Alert(title: Text("Daily Quest App"), message: Text("\nThis is an app where you can add daily activities as a 'Quest' and mark them completed as you clear your objectives throughout the day/week."))
                        }
                    Spacer()
                }
            }.offset(y: -240)
        }
    }
}

   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

