import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }
            
            ExamView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Sınavlar")
                }
            
            StudyView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Çalışma")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
        }
        .accentColor(Color("AccentColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 