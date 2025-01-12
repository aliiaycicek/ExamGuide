import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppTheme.padding) {
                    // Günlük özet kartı
                    DailySummaryCard()
                    
                    // Hedefler kartı
                    GoalsCard()
                    
                    // Çalışma istatistikleri
                    StatisticsGridView()
                }
                .padding(.horizontal)
            }
            .background(AppTheme.background)
            .navigationTitle("Merhaba, Ali!")
        }
    }
}

struct DailySummaryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Bugünkü Durum")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.textPrimary)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(AppTheme.accent)
            }
            
            HStack(spacing: 20) {
                VStack {
                    Text("4s 30dk")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primary)
                    Text("Çalışma")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                VStack {
                    Text("250")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primary)
                    Text("Soru")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                VStack {
                    Text("%85")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.primary)
                    Text("Başarı")
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .applyCardStyle()
    }
}

struct GoalsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Hedeflerim")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textPrimary)
            
            VStack(spacing: 16) {
                GoalProgressView(
                    title: "Günlük Çalışma",
                    current: 4.5,
                    target: 6,
                    unit: "saat"
                )
                
                GoalProgressView(
                    title: "Soru Çözümü",
                    current: 250,
                    target: 300,
                    unit: "soru"
                )
            }
        }
        .applyCardStyle()
    }
}

struct GoalProgressView: View {
    let title: String
    let current: Double
    let target: Double
    let unit: String
    
    var progress: Double {
        min(current / target, 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .foregroundColor(AppTheme.textPrimary)
                Spacer()
                Text("\(Int(current))/\(Int(target)) \(unit)")
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(AppTheme.secondary.opacity(0.2))
                    
                    Rectangle()
                        .fill(AppTheme.primaryGradient)
                        .frame(width: geometry.size.width * progress)
                }
            }
            .frame(height: 8)
            .cornerRadius(4)
        }
    }
}

struct StatisticsGridView: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            StatCard(
                title: "Toplam Çalışma",
                value: "120 saat",
                icon: "clock.fill"
            )
            
            StatCard(
                title: "Çözülen Soru",
                value: "1500",
                icon: "checkmark.circle.fill"
            )
            
            StatCard(
                title: "Başarı Oranı",
                value: "%85",
                icon: "chart.line.uptrend.xyaxis"
            )
            
            StatCard(
                title: "Deneme Sınavı",
                value: "12",
                icon: "doc.fill"
            )
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(AppTheme.primary)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.textPrimary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(AppTheme.cornerRadius)
        .shadow(color: AppTheme.primary.opacity(0.1), radius: AppTheme.shadowRadius, x: 0, y: 4)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
} 

