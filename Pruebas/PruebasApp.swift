//
//  PruebasApp.swift
//  Pruebas
//
//  Created by c060 DIT UPM on 29/11/23.
//

import SwiftUI

@main
struct PruebasApp: App {
    @State var scoresModel = ScoresModel()
    @State var quizzesModel = QuizzesModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(scoresModel)
                .environment(quizzesModel)
              
        }
    }
}
