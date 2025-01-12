import SwiftUI

struct StudyView: View {
    @State private var selectedSubject = "Matematik"
    let subjects = ["Matematik", "Fizik", "Kimya", "Biyoloji", "Türkçe", "Tarih"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arkaplan gradientleri
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
                        // Konu seçici
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(subjects, id: \.self) { subject in
                                    SubjectButton(
                                        title: subject,
                                        isSelected: selectedSubject == subject
                                    ) {
                                        withAnimation {
                                            selectedSubject = subject
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Konular listesi
                        VStack(spacing: 16) {
                            ForEach(0..<5) { _ in
                                NavigationLink(destination: TopicDetailView()) {
                                    TopicRowView()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Çalışma")
            .toolbar {
                Button(action: {
                    // Yeni çalışma ekle
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(AppTheme.accent)
                }
            }
        }
    }
}

struct SubjectButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundColor(isSelected ? .white : AppTheme.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Group {
                        if isSelected {
                            AppTheme.primaryGradient
                        } else {
                            Color.clear
                        }
                    }
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.clear : AppTheme.primary, lineWidth: 1)
                )
        }
    }
}

struct TopicRowView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Türev")
                        .font(.headline)
                        .foregroundColor(AppTheme.textPrimary)
                    Text("Son çalışma: 2 gün önce")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                Spacer()
                
                ProgressRing(progress: 0.65)
                    .frame(width: 50, height: 50)
            }
            
            HStack(spacing: 16) {
                StatisticView(title: "Soru", value: "150")
                StatisticView(title: "Doğru", value: "120")
                StatisticView(title: "Yanlış", value: "30")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .stroke(AppTheme.glassMorphism, lineWidth: 1)
                )
        )
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct ProgressRing: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(AppTheme.secondary.opacity(0.2), lineWidth: 4)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AppTheme.primaryGradient,
                    style: StrokeStyle(lineWidth: 4, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.primary)
        }
    }
}

struct StatisticView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.primary)
            Text(title)
                .font(.caption)
                .foregroundColor(AppTheme.textSecondary)
        }
    }
}

struct TopicDetailView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.padding) {
                // Konu özeti kartı
                SummaryCard()
                
                // Alt konular
                SubtopicsCard()
                
                // Çözülen sorular
                SolvedQuestionsCard()
            }
            .padding()
        }
        .background(AppTheme.background)
        .navigationTitle("Türev")
    }
}

struct SummaryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Konu Özeti")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textPrimary)
            
            Text("Türev, bir fonksiyonun herhangi bir noktadaki değişim oranını verir...")
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: AppTheme.primary.opacity(0.1), radius: AppTheme.shadowRadius, x: 0, y: 4)
    }
}

struct SubtopicsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Alt Konular")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textPrimary)
            
            ForEach(0..<3) { _ in
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(AppTheme.success)
                    Text("Türev Alma Kuralları")
                        .foregroundColor(AppTheme.textPrimary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: AppTheme.primary.opacity(0.1), radius: AppTheme.shadowRadius, x: 0, y: 4)
    }
}

struct SolvedQuestionsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Çözülen Sorular")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textPrimary)
            
            VStack(spacing: 8) {
                StatRow(title: "Toplam Soru", value: "150")
                StatRow(title: "Doğru", value: "120", color: AppTheme.success)
                StatRow(title: "Yanlış", value: "30", color: AppTheme.error)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: AppTheme.primary.opacity(0.1), radius: AppTheme.shadowRadius, x: 0, y: 4)
    }
}

struct StatRow: View {
    let title: String
    let value: String
    var color: Color = AppTheme.primary
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(AppTheme.textPrimary)
            Spacer()
            Text(value)
                .fontWeight(.bold)
                .foregroundColor(color)
        }
    }
}

struct StudyView_Previews: PreviewProvider {
    static var previews: some View {
        StudyView()
    }
} 