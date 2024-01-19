import SwiftUI


struct QuizItemRowView: View {
    var quizItem: QuizItem
    var body: some View {

       HStack (spacing:20) {
       AsyncImage(url:quizItem.attachment?.url)
        .frame(width:60, height:60)
        .scaledToFill()
        .clipShape(Circle())
        .overlay{
           Circle().stroke(Color.blue, lineWidth: 1)
            }
        .shadow(color: .blue, radius:1, x:1, y:1)


       
         VStack(alignment: .leading) {
        Image(quizItem.favourite ? "estrella-amarilla" : "estrella-gris").resizable().frame(width: 40,height: 40)
        Text(quizItem.question)
                 .lineLimit(3)
        
       


        }
         
           
        Text(quizItem.author?.username ?? quizItem.author?.profileName ?? "Anónimo")
               .font(.caption)
        FacilAsyncImage(url:quizItem.author?.photo?.url)
         .frame(width:30, height:30)
        .scaledToFill()
        .clipShape(Circle())
        .overlay{
           Circle().stroke(Color.blue, lineWidth: 1)
            }
        .shadow(color: .blue, radius:10)


    }
    }
}

/*
#Preview { //Maaaaaaaaal 
    var model:QuizzesModel = {
        var m = QuizzesModel()
        m.download()
        return m
    } ()


    return
    QuizItemRowView(quizItem: model.quizzes[0])
}
*/
