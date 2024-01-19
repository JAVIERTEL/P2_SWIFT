//
//  Endpoints.swift
//  Pruebas
//
//  Created by c035 DIT UPM on 12/12/23.
//

import Foundation

let urlBase = "https://quiz.dit.upm.es"

let token = "7f674996a15f96ddbcec"

struct Endpoints{
    
    static func random10() -> URL? {
        let path = "/api/quizzes/random10"
        
        let str = "\(urlBase)\(path)?token=\(token)"
        
        return URL(string : str)
    }
    
    
    static func devuelveUrl(quizItem: QuizItem,answer : String) -> URL? {
        let path = "/api/quizzes/\(quizItem.id)/check"
        guard let escapedAnswer = answer.addingPercentEncoding(withAllowedCharacters:
                .urlQueryAllowed) else {
            return nil
        }
        let str = "\(urlBase)\(path)?answer=\(escapedAnswer)&token=\(token)"
        
        return URL(string : str)
    }
    
    static func toggleFav(quizItem: QuizItem) -> URL? {
        let path = "/api/users/tokenOwner/favourites/\(quizItem.id)"
        let str = "\(urlBase)\(path)?token=\(token)"
        return URL(string : str)
    }
    
    static func devuelveRespuesta(quizItem: QuizItem) -> URL? {
        let path = "/api/quizzes/\(quizItem.id)/answer?token=\(token)"
        let str = "\(urlBase)\(path)"
        return URL(string: str)
    }
    
    
    
}
