//
//  ContentView.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-04.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
    @State private var loginScreen = false

    var body: some View {
     
        NavigationView {
            VStack {
                Spacer().frame(height: 150)
               
                
                
                Spacer().frame(height: 30)
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
                
                Button(action: {
                    self.loginScreen.toggle()
                }) {
                    Text("Login")
                }.fullScreenCover(isPresented: $loginScreen) {
                    LoginScreen()
                }.offset(y: 50)
                
            }.offset(y: -240)
       }
    }
}

   
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

