//
//  QuizzesModel.swift
//  P4.1 Quiz
//
//  Created by Santiago Pavón Gómez on 11/9/23.
//

import Foundation

@Observable class QuizzesModel: ObservableObject {
    
    
   
    // Los datos
    private(set) var quizzes = [QuizItem]()
    
    
    func download() async throws {
         
        guard let url = Endpoints.random10() else {
            throw "No se pudo crear la URL"
            }
            
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No se ha podido construir la URL"
        }
            
            // print("Quizzes ==>", String(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
            
            guard let quizzes = try? JSONDecoder().decode([QuizItem].self, from: data)  else {
                throw "Error: recibidos datos corruptos."
            }
        
            self.quizzes = quizzes
            
            print("Quizzes cargados")
        
        }
    
    func check(quizItem: QuizItem , answer : String) async throws -> Bool{
        guard let url = Endpoints.devuelveUrl(quizItem: quizItem , answer: answer) else {
            throw "No se puede comprobar la respuesta"
            }
            
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No se ha podido construir la URL"
        }
            
            // print("Quizzes ==>", String(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
            
            guard let res = try? JSONDecoder().decode(checkResponseItem.self, from: data)  else {
                throw "Error: recibidos datos corruptos."
            }
        
        return res.result
            
        
        
    }
    
    func devuelveAnswer(quizItem: QuizItem) async throws -> String{
        guard let url = Endpoints.devuelveRespuesta(quizItem: quizItem) else {
            throw "No se puede comprobar la respuesta"
            }
            
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No se ha podido construir la URL"
        }
            
            // print("Quizzes ==>", String(data: data, encoding: String.Encoding.utf8) ?? "JSON incorrecto")
            
            guard let res = try? JSONDecoder().decode(checkRespuesta.self, from: data)  else {
                throw "Error: recibidos datos corruptos."
            }
        
        return res.answer
            
        
        
    }
    
    func toggleFavourite(quizItem:QuizItem) async throws {
        guard let url = Endpoints.toggleFav(quizItem:quizItem) else {
            throw "No puedo comprobar la respuesta"
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = quizItem.favourite ? "DELETE" : "PUT"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw "No se ha podido contruir la URL"
        }
        
        guard let res = try? JSONDecoder().decode(FavouriteStatusItem.self, from: data) else {
            throw "Error : recibidos datos corruptos"
            
        }
        print (url)
        guard let index = quizzes.firstIndex(where: { qi in qi.id == quizItem.id}) else{
            throw "Error AAAAAAAAA"
        }
        quizzes[index].favourite = res.favourite
    }
     
    }
    
    

