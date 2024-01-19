//
//  ScoresModel.swift
//  Quiz28
//
//  Created by c035 DIT UPM on 28/11/23.
//

import Foundation

@Observable class ScoresModel: ObservableObject {

    var score : Int = 0
    
    var acertadas : Set<Int> = []
    var record : Set<Int> = []

    
    init() {
        // Cargar los datos guardados previamente, si existen
        if let savedScore = UserDefaults.standard.value(forKey: "score") as? Int {
            score =  savedScore
        }
        let savedRecord = UserDefaults.standard.object(forKey: "record") as? [Int] ?? []
        
        record = Set (savedRecord)

        
       
    }
    
    func add(quizItem: QuizItem) {
            acertadas.insert(quizItem.id)
        if acertadas.count > record.count{
            record.insert(quizItem.id)
        }
        
            
            /*UserDefaults.standard.set(record, forKey: "record")
            UserDefaults.standard.synchronize()
             */
             
        }
    
    func pendiente(_ quizItem: QuizItem) -> Bool{
        !acertadas.contains(quizItem.id)
    }
    
    
        
      
        
        
        
}
