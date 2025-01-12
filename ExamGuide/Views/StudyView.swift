import SwiftUI

struct StudyView: View {
    @State private var selectedSubject = "Matematik"
    let subjects = ["Matematik", "Fizik", "Kimya", "Biyoloji", "Türkçe", "Tarih"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Konu seçici
                Picker("Ders", selection: $selectedSubject) {
                    ForEach(subjects, id: \.self) { subject in
                        Text(subject).tag(subject)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    Section(header: Text("Konular")) {
                        ForEach(0..<5) { _ in
                            NavigationLink(destination: TopicDetailView()) {
                                TopicRowView()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Çalışma")
            .toolbar {
                Button(action: {
                    // Yeni çalışma ekle
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct TopicRowView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Türev")
                    .font(.headline)
                Text("Son çalışma: 2 gün önce")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            CircularProgressView(progress: 0.65)
                .frame(width: 40, height: 40)
        }
        .padding(.vertical, 4)
    }
}

struct TopicDetailView: View {
    var body: some View {
        List {
            Section(header: Text("Konu Özeti")) {
                Text("Türev, bir fonksiyonun herhangi bir noktadaki değişim oranını verir...")
                    .font(.body)
            }
            
            Section(header: Text("Alt Konular")) {
                ForEach(0..<3) { _ in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Türev Alma Kuralları")
                    }
                }
            }
            
            Section(header: Text("Çözülen Sorular")) {
                HStack {
                    Text("Toplam Soru")
                    Spacer()
                    Text("150")
                        .bold()
                }
                
                HStack {
                    Text("Doğru")
                    Spacer()
                    Text("120")
                        .foregroundColor(.green)
                        .bold()
                }
                
                HStack {
                    Text("Yanlış")
                    Spacer()
                    Text("30")
                        .foregroundColor(.red)
                        .bold()
                }
            }
        }
        .navigationTitle("Türev")
    }
}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
    }
} 