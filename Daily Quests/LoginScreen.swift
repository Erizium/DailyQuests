//
//  LoginScreen.swift
//  Daily Quests
//
//  Created by Tobias Österlin on 2021-02-11.
//

import SwiftUI
import Firebase

struct LoginScreen: View {
    
    var db = Firestore.firestore()
    
    var body: some View {
        Button(action: {
            saveToFirestore()
        }) {
            Text("Save")
        }
    }
    
    func saveToFirestore(){
        db.collection("test").addDocument(data: ["name" : "Tobias"])
    }
    
    
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
