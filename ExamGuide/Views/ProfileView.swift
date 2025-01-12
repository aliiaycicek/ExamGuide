import SwiftUI

struct ProfileView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var targetUniversity = ""
    @State private var targetDepartment = ""
    @State private var dailyStudyGoal = ""
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Kişisel Bilgiler")) {
                    HStack {
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    TextField("Ad Soyad", text: $name)
                    TextField("E-posta", text: $email)
                }
                
                Section(header: Text("Hedefler")) {
                    TextField("Hedef Üniversite", text: $targetUniversity)
                    TextField("Hedef Bölüm", text: $targetDepartment)
                    TextField("Günlük Çalışma Hedefi (Saat)", text: $dailyStudyGoal)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: {
                        showingSettings = true
                    }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Ayarlar")
                        }
                    }
                    
                    Button(action: {
                        // Çıkış yap
                    }) {
                        HStack {
                            Image(systemName: "arrow.right.square")
                            Text("Çıkış Yap")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profil")
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var notifications = true
    @State private var darkMode = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Uygulama")) {
                    Toggle("Bildirimler", isOn: $notifications)
                    Toggle("Karanlık Mod", isOn: $darkMode)
                }
                
                Section(header: Text("Hakkında")) {
                    HStack {
                        Text("Versiyon")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Ayarlar")
            .navigationBarItems(trailing: Button("Tamam") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 