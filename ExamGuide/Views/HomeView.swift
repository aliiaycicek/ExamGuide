import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Günlük Hedef Kartı
                    DailyGoalCard()
                    
                    // Son Çalışmalar
                    RecentStudiesCard()
                    
                    // İstatistikler
                    StatisticsCard()
                }
                .padding()
            }
            .navigationTitle("YKS Hazırlık")
        }
    }
}

struct DailyGoalCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Günlük Hedef")
                .font(.headline)
            
            HStack {
                CircularProgressView(progress: 0.7)
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading) {
                    Text("4 saat 30 dakika")
                        .font(.title3)
                        .bold()
                    Text("Günlük hedefinizin %70'ini tamamladınız")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct RecentStudiesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Son Çalışmalar")
                .font(.headline)
            
            ForEach(0..<3) { _ in
                HStack {
                    Image(systemName: "book.fill")
                        .foregroundColor(.blue)
                    Text("Matematik - Türev")
                    Spacer()
                    Text("45 dk")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct StatisticsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("İstatistikler")
                .font(.headline)
            
            HStack {
                StatItem(title: "Toplam Süre", value: "120 saat")
                Spacer()
                StatItem(title: "Çözülen Soru", value: "1500")
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct StatItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
    }
}

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.blue)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            Text(String(format: "%.0f%%", min(progress, 1.0) * 100.0))
                .font(.caption)
                .bold()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 