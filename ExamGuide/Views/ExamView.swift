import SwiftUI

struct ExamView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("YKS Sınavları")) {
                    NavigationLink(destination: ExamDetailView(examType: "TYT")) {
                        ExamRowView(title: "TYT", date: "18 Haziran 2024", remainingDays: 120)
                    }
                    
                    NavigationLink(destination: ExamDetailView(examType: "AYT")) {
                        ExamRowView(title: "AYT", date: "19 Haziran 2024", remainingDays: 121)
                    }
                }
                
                Section(header: Text("Deneme Sınavları")) {
                    ForEach(0..<3) { _ in
                        NavigationLink(destination: ExamDetailView(examType: "Deneme")) {
                            ExamRowView(title: "Deneme Sınavı", date: "15 Nisan 2024", remainingDays: 30)
                        }
                    }
                }
            }
            .navigationTitle("Sınavlar")
            .toolbar {
                Button(action: {
                    // Yeni deneme sınavı ekle
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ExamRowView: View {
    let title: String
    let date: String
    let remainingDays: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(date)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(remainingDays) gün kaldı")
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding(.vertical, 4)
    }
}

struct ExamDetailView: View {
    let examType: String
    
    var body: some View {
        List {
            Section(header: Text("Sınav Bilgileri")) {
                DetailRow(title: "Sınav", value: examType)
                DetailRow(title: "Tarih", value: "18 Haziran 2024")
                DetailRow(title: "Süre", value: "135 dakika")
            }
            
            Section(header: Text("Konular")) {
                ForEach(0..<5) { _ in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Matematik - Türev")
                        Spacer()
                        Text("%85")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle(examType)
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .bold()
        }
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView()
    }
} 