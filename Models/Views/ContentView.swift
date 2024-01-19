import SwiftUI

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

struct ContentView: View {
    @Environment(QuizzesModel.self)  var quizzesModel
    @Environment(ScoresModel.self) var scoresModel
    @State var errorMsg = "" {
        didSet {
            showErrorMsgAlert = true
        }
    }
    
    
    @State var showErrorMsgAlert = false
    @State var showAll = true
    
    var body: some View {
        
        NavigationStack {
            
            List {
                Toggle("Ver todos", isOn: $showAll)
                
                ForEach(quizzesModel.quizzes) { quizItem in
                    if showAll || scoresModel.pendiente(quizItem){
                        NavigationLink(
                            destination: QuizItemPlayView(quizItem: quizItem)
                                .background(
                                                 LinearGradient(
                                                     gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white]),
                                                     startPoint: .top,
                                                     endPoint: .bottom
                                                 )
                                                 .edgesIgnoringSafeArea(.all)  // Asegúrate de que el fondo cubra toda la ventana
                                             )
                        ) {
                            QuizItemRowView(quizItem: quizItem)
                                
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("P4 QUIZZES")
            .navigationBarItems(
                leading: Text("RECORD= \(scoresModel.record.count)")
                    .foregroundColor(Color(UIColor.systemYellow)) // Cambia el color del texto a rojo
                    .font(Font.system(size: 18, weight: .bold)),  // Ajusta el tamaño y el peso de la fuente

                trailing: Button(action: {
                    Task {
                        do {
                            try await quizzesModel.download()
                            scoresModel.acertadas = []
                        } catch {
                            errorMsg = error.localizedDescription
                        }
                    }
                }, label: {
                    Label("Refrescar", systemImage: "arrow.counterclockwise")
                })
            )
            .alert("Error", isPresented: $showErrorMsgAlert) {
                Text(errorMsg)
            }

            .task {
                do {
                    guard quizzesModel.quizzes.count == 0 else { return }
                    try await quizzesModel.download()
                } catch {
                    errorMsg = error.localizedDescription
                }
            }
            .padding()
        }
    }
}


