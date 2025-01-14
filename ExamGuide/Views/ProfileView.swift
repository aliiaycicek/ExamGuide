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
            ZStack {
                // Arkaplan
                AppTheme.background
                    .ignoresSafeArea()
                
                // Dekoratif şekiller
                Circle()
                    .fill(AppTheme.accent.opacity(0.1))
                    .frame(width: 200, height: 200)
                    .blur(radius: 50)
                    .offset(x: -100, y: -200)
                
                Circle()
                    .fill(AppTheme.secondary.opacity(0.1))
                    .frame(width: 300, height: 300)
                    .blur(radius: 60)
                    .offset(x: 150, y: 250)
                
                ScrollView {
                    VStack(spacing: AppTheme.padding) {
                        // Profil Resmi
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(AppTheme.accent)
                            
                            Text("Profil Fotoğrafı Ekle")
                                .font(.caption)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding(.vertical)
                        
                        // Kişisel Bilgiler
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Kişisel Bilgiler")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(AppTheme.textHeadline)
                            
                            CustomTextField(title: "Ad Soyad", text: $name)
                            CustomTextField(title: "E-posta", text: $email)
                        }
                        .padding()
                        .background(AppTheme.cardGradient)
                        .cornerRadius(AppTheme.cornerRadius)
                        
                        // Hedefler
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Hedefler")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(AppTheme.textHeadline)
                            
                            CustomTextField(title: "Hedef Üniversite", text: $targetUniversity)
                            CustomTextField(title: "Hedef Bölüm", text: $targetDepartment)
                            CustomTextField(title: "Günlük Çalışma Hedefi (Saat)", text: $dailyStudyGoal)
                                .keyboardType(.numberPad)
                        }
                        .padding()
                        .background(AppTheme.cardGradient)
                        .cornerRadius(AppTheme.cornerRadius)
                        
                        // Ayarlar ve Çıkış
                        VStack(spacing: 12) {
                            Button(action: { showingSettings = true }) {
                                HStack {
                                    Image(systemName: "gear")
                                    Text("Ayarlar")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppTheme.cardGradient)
                                .foregroundColor(AppTheme.textPrimary)
                                .cornerRadius(AppTheme.cornerRadius)
                            }
                            
                            Button(action: { /* Çıkış işlemi */ }) {
                                HStack {
                                    Image(systemName: "arrow.right.square")
                                    Text("Çıkış Yap")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red.opacity(0.2))
                                .foregroundColor(AppTheme.error)
                                .cornerRadius(AppTheme.cornerRadius)
                            }
                        }
                    }
                    .padding()
                }
            }
            .customNavigationTitle("Profil", color: AppTheme.navigationTitle)
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
        }
    }
}

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(AppTheme.textSecondary)
            
            TextField("", text: $text)
                .textFieldStyle(CustomTextFieldStyle())
                .foregroundColor(AppTheme.textPrimary)
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(AppTheme.surface)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppTheme.glassMorphism, lineWidth: 1)
            )
    }
}

// Navigation bar başlık rengi için extension
extension View {
    func customNavigationTitle(_ title: String, color: Color) -> some View {
        self.navigationTitle(title)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(AppTheme.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .foregroundColor(color)
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var notifications = true
    @State private var darkMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: AppTheme.padding) {
                        // Uygulama Ayarları
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Uygulama Ayarları")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(AppTheme.textHeadline)
                            
                            ToggleRow(title: "Bildirimler", isOn: $notifications)
                            ToggleRow(title: "Karanlık Mod", isOn: $darkMode)
                        }
                        .padding()
                        .background(AppTheme.cardGradient)
                        .cornerRadius(AppTheme.cornerRadius)
                        
                    
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Hakkında")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(AppTheme.textHeadline)
                            
                            HStack {
                                Text("Versiyon")
                                    .foregroundColor(AppTheme.textPrimary)
                                Spacer()
                                Text("1.0.0")
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                        }
                        .padding()
                        .background(AppTheme.cardGradient)
                        .cornerRadius(AppTheme.cornerRadius)
                    }
                    .padding()
                }
            }
            .customNavigationTitle("Ayarlar", color: AppTheme.navigationTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Tamam") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(AppTheme.accent)
                }
            }
        }
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
                .foregroundColor(AppTheme.textPrimary)
        }
        .tint(AppTheme.accent)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
} 
