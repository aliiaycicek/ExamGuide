import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Ana Sayfa")
                }
            
            ResourceView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Kaynaklar")
                }
            
            StudyView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Çalışma")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profil")
                }
        }
        .tint(AppTheme.primary)
        .background(AppTheme.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 