//
//  ContentView.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

struct ContentView: View {
  

    var body: some View {
     
        
        NavigationView {
            VStack {

                NavigationLink(destination: YourDailyQuests()) {
                    ZStack {

                        Image("PreviewImage")
                            .resizable()
                            .frame(width: 300, height: 150)
                            .cornerRadius(7)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 10,
                                    x: 0, y: 10)

                        Text("Daily Quests")
                            .foregroundColor(.red)
                            .offset(x: -50, y: -30)
                            .font(.title)
                    }
                }

                Spacer().frame(height: 50)
                
                NavigationLink(destination: YourWeeklyQuests()) {

                    ZStack {
                        Image("PreviewImage")
                            .resizable()
                            .frame(width: 300, height: 150)
                            .cornerRadius(7)
                            .shadow(color: .black, radius: 10,
                                    x: 0, y: 10)

                        Text("Weekly Quests")
                            .foregroundColor(.red)
                            .offset(x: -40, y: -30)
                            .font(.title)
                    }
                }
            }.padding(.top, 150)
            .offset(y: -240)
       } 
    }
}

   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

