import SwiftUI

struct AppTheme {
    // Ana renkler
    static let primary = Color("PrimaryColor") // Açık Mavi - #64B5F6
    static let secondary = Color("SecondaryColor") // Turkuaz - #4DD0E1
    static let accent = Color("AccentColor") // Canlı Turuncu - #FFB74D
    
    // Yardımcı renkler
    static let background = Color("BackgroundColor") // Koyu Lacivert - #152642
    static let cardBackground = Color("CardBackgroundColor") // Yarı Saydam Lacivert - #1E3D59 (opacity: 0.7)
    static let surface = Color("SurfaceColor") // Yarı Saydam Gri - #FFFFFF (opacity: 0.1)
    
    // Başarı/Hata renkleri
    static let success = Color("SuccessColor") // Parlak Yeşil - #81C784
    static let warning = Color("WarningColor") // Parlak Sarı - #FFD54F
    static let error = Color("ErrorColor") // Parlak Kırmızı - #FF8A80
    
    // Text renkleri
    static let textPrimary = Color("TextPrimaryColor") // Açık Gri - #E8EDF3
    static let textSecondary = Color("TextSecondaryColor") // Soluk Mavi - #B8C5D9
    static let textHeadline = Color("TextHeadlineColor") // Parlak Gri - #F5F7FA
    
    // Navigation başlık rengi
    static let navigationTitle = Color("NavigationTitleColor") // Parlak Beyaz - #FFFFFF
    
    // Gradient tanımlamaları
    static let primaryGradient = LinearGradient(
        colors: [
            Color("GradientStart"), // #64B5F6
            Color("GradientEnd")    // #4DD0E1
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let cardGradient = LinearGradient(
        colors: [
            Color.white.opacity(0.15),
            Color.white.opacity(0.05)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Stil sabitleri
    static let cornerRadius: CGFloat = 20
    static let shadowRadius: CGFloat = 10
    static let padding: CGFloat = 16
    
    // Özel stil tanımlamaları
    static let glassMorphism = Color.white.opacity(0.1)
}

// MARK: - View Modifiers
extension View {
    func applyCardStyle() -> some View {
        self
            .padding(AppTheme.padding)
            .background(AppTheme.cardBackground)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: AppTheme.primary.opacity(0.1), radius: AppTheme.shadowRadius, x: 0, y: 4)
    }
    
    func applyPrimaryButtonStyle() -> some View {
        self
            .padding()
            .background(AppTheme.primaryGradient)
            .foregroundColor(Color.white)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: AppTheme.primary.opacity(0.3), radius: 8, x: 0, y: 4)
    }
} 
