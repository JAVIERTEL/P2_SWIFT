//
//  QuizItemPlayView.swift
//  Quiz
//
//  Created by c035 DIT UPM on 16/11/23.
//

import SwiftUI

struct QuizItemPlayView: View {
    
    
    @Environment(QuizzesModel.self)  var quizzesModel
    @Environment(ScoresModel.self)  var scoresModel

    @State private var doubleTapDetected = false // Variable para controlar el doble tap

    
    
    @Environment(\.verticalSizeClass) var vsc

    //@Environment(ScoreModel.self) var scoresModel
    
    
    
    var quizItem: QuizItem
    
    @State var answer : String = ""
    @State var errorMsg = ""{
        didSet {
            showErrorMsgAlert = true
        }
    }
    @State var showErrorMsgAlert = false

    
    @State var showCheckAlert = false
    
    @State var checkingResponse = false
    
    @State var answerIsOk = false
    
    @State private var alertMessage = ""
    
    var body: some View {
        VStack{
            if (vsc == .compact){
                VStack{
                    
                titulo
                Spacer()
                    HStack{
                        adjunto
                        Spacer()
                        VStack{
                            Spacer()
                            pregunta
                           Spacer()
                            puntos
                            Spacer()
                            autor
                            
                        }
                        
                        
                    }
               
    
                }
            }
                else{
                    VStack{
                        titulo
                        Spacer()
                        pregunta
                        Spacer()
                        adjunto
                        Spacer()
                        Spacer()
                        HStack{
                            puntos
                            Spacer()
                            autor
                        }
                    }
            }
            
            
        }
        .padding()
        .navigationTitle("Playing")
        .alert ("Error", isPresented: $showErrorMsgAlert){
            
        } message: {Text(errorMsg)
        
        }
    }
    
    
    private var titulo: some View{
        HStack{
            Text(quizItem.question)
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            Button{
                Task{
                    do {
                        try await quizzesModel.toggleFavourite(quizItem: quizItem)
                        
                    }catch {
                        errorMsg = error.localizedDescription
                    }
                }
            }
                label : {
                    Image(quizItem.favourite ? "estrella-amarilla" : "estrella-gris").resizable().frame(width: 40,height: 40) // Ajusta el radio según sea necesario

                }
                
            
        }
    }
    
    private var pregunta: some View{
        VStack{
            TextField("Introduzca la respuesta", text: $answer)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    Task {
                        await checkResponse()
                    }
                    
                }
            
            if checkingResponse {
                ProgressView()
            }else{
                
                Button("Comprobar") {
                    Task {
                        await checkResponse()
                    }
                }
                .buttonStyle(MyButtonStyle())
                .padding()
                
                
                //}else{
                
                
                
            }
            
            
            
        }
        .alert("Resultado", isPresented: $showCheckAlert){
        }message : {
            Text(alertMessage)
        }
    }
    
    
    
    
    private var adjunto : some View{
        GeometryReader { g in
            FacilAsyncImage(url: quizItem.attachment?.url)
                .frame(width: g.size.width, height: g.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.blue, lineWidth:2)
                    
                }
                .shadow(color: .yellow, radius: 2)
                .scaleEffect(doubleTapDetected ? 1.2 : 1.0)
                .onTapGesture(count: 2) {
                            Task {
                                do {
                                        try await answer = quizzesModel.devuelveAnswer(quizItem: quizItem)
                                        withAnimation{
                                        doubleTapDetected = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                withAnimation {
                                                                    doubleTapDetected = false // Restablecemos la escala después de un breve retraso
                                                                }
                                                            }
                                    }catch {
                                        errorMsg = error.localizedDescription
                                    }
                                }
                                      }
    }
    }

    private var autor: some View{
        HStack{
            Spacer()
            Text(quizItem.author?.username ?? quizItem.author?.profileName ?? "Anónimo")
            FacilAsyncImage(url: quizItem.author?.photo?.url)
                .frame(width:30, height: 30)
                .scaledToFill()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Color.blue, lineWidth: 2)
                    
                }
                .shadow(color: .yellow, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .contextMenu(menuItems : {
                    Button ("Limpiar") {
                        Task{
                            answer = ""
                        }
                    }
                    Button("Rellenar") {
                        Task{
                            do{
                                try await answer = quizzesModel.devuelveAnswer(quizItem: quizItem)

                            }catch{
                                errorMsg = error.localizedDescription
                            }
                        }
                    }
                    
                    
                    //, label {
                       // Label("Limpiar", systemImage: "x.circle")
                    //}
                    
                })
                             
            
        }
        
    }
    
    private var puntos : some View {
        
        
            
            Text("Puntos = \(scoresModel.acertadas.count)")
                .font(.title)
                .foregroundStyle(.mint)
                .fontDesign(.serif)
        
        }
    
    
    /*private func checkAnswer() {
           scoresModel.checkAnswer(quizItem: quizItem, answer: answer)
       }*/
    
    func checkResponse() async {
        do{
        checkingResponse = true
        let answerIsOk = try await quizzesModel.check(quizItem:quizItem, answer:  answer)
        showCheckAlert = true
        
            if answerIsOk{
                alertMessage = "Bien"
                scoresModel.add(quizItem: quizItem)
                        } else {
                            alertMessage = "Mal"
                        }
            
        checkingResponse = false
        }catch{
            errorMsg = error.localizedDescription
        }
        
    }
    struct MyButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
        }
    }

    
    }
/*
#Preview {
    var model:QuizzesModel = {
        var m = QuizzesModel()
        m.download()
        return m
    } ()
    return NavigationStack {
        QuizItemPlayView(quizItem: model.quizzes[0])
    }
}
*/

