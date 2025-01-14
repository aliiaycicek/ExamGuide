import SwiftUI

struct ResourceView: View {
    @StateObject private var viewModel = ResourceViewModel()
    @State private var showingProgressInput = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppTheme.padding) {
                
                    MotivationCard()
                    
                
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ders İlerlemen")
                            .font(.title2)
                            .bold()
                            .foregroundColor(AppTheme.textPrimary)
                        
                        ForEach(viewModel.subjectProgress, id: \.subject) { progress in
                            ProgressRowView(progress: progress)
                                .applyCardStyle()
                        }
                        
                        AddProgressButton(action: { showingProgressInput = true })
                    }
                    .padding(.horizontal)
                    
                    if let selectedProgress = viewModel.selectedProgress {
                        // Gemini analizi
                        AnalysisCard(analysis: viewModel.analysis)
                        
                        // Önerilen kaynaklar
                        RecommendedResourcesSection(
                            isLoading: viewModel.isLoading,
                            resources: viewModel.recommendedResources
                        )
                    }
                }
            }
            .background(AppTheme.background)
            .customNavigationTitle("Kaynaklar", color: AppTheme.navigationTitle)
            .sheet(isPresented: $showingProgressInput) {
                ProgressInputView(viewModel: viewModel)
            }
        }
    }
}

struct MotivationCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Günün Motivasyonu")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.textPrimary)
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(AppTheme.accent)
            }
            
            Text("\"Başarı, her gün küçük adımlar atarak başlar. Bugün atacağın adım, yarının zaferidir.\"")
                .font(.body)
                .foregroundColor(AppTheme.textSecondary)
                .italic()
            
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(AppTheme.accent)
                Text("İpucu: Günlük çalışma rutini oluşturmak başarıyı artırır!")
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
            .padding(.top, 4)
        }
        .applyCardStyle()
        .padding(.horizontal)
    }
}

struct AddProgressButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "plus.circle.fill")
                Text("Yeni İlerleme Ekle")
            }
            .frame(maxWidth: .infinity)
        }
        .applyPrimaryButtonStyle()
    }
}

struct AnalysisCard: View {
    let analysis: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Kişisel Analiz")
                .font(.headline)
                .foregroundColor(AppTheme.textPrimary)
            
            if let analysis = analysis {
                Text(analysis)
                    .foregroundColor(AppTheme.textSecondary)
            } else {
                Text("Analiz yükleniyor...")
                    .foregroundColor(AppTheme.textSecondary)
                    .italic()
            }
        }
        .applyCardStyle()
        .padding(.horizontal)
    }
}

struct RecommendedResourcesSection: View {
    let isLoading: Bool
    let resources: [Resource]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Önerilen Kaynaklar")
                .font(.headline)
                .foregroundColor(AppTheme.textPrimary)
            
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else {
                ForEach(resources, id: \.name) { resource in
                    ResourceRowView(resource: resource)
                        .applyCardStyle()
                }
            }
        }
        .padding(.horizontal)
    }
}

class ResourceViewModel: ObservableObject {
    @Published var subjectProgress: [SubjectProgress] = []
    @Published var selectedProgress: SubjectProgress?
    @Published var analysis: String?
    @Published var recommendedResources: [Resource] = []
    @Published var isLoading = false
    
    private let geminiService = GeminiService()
    
    func addProgress(_ progress: SubjectProgress) {
        subjectProgress.append(progress)
        selectProgress(progress)
    }
    
    func selectProgress(_ progress: SubjectProgress) {
        selectedProgress = progress
        Task {
            await analyzeAndGetRecommendations(for: progress)
        }
    }
    
    @MainActor
    private func analyzeAndGetRecommendations(for progress: SubjectProgress) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            async let analysisTask = geminiService.analyzeStudentLevel(progress: progress)
            async let recommendationsTask = geminiService.getResourceRecommendations(progress: progress)
            
            let (analysis, recommendations) = try await (analysisTask, recommendationsTask)
            self.analysis = analysis
            self.recommendedResources = recommendations
        } catch {
            print("Error: \(error)")
        }
    }
}

struct ProgressInputView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ResourceViewModel
    
    @State private var subject = ""
    @State private var currentNet = ""
    @State private var targetNet = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Ders", text: $subject)
                TextField("Mevcut Net", text: $currentNet)
                    .keyboardType(.decimalPad)
                TextField("Hedef Net", text: $targetNet)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("İlerleme Ekle")
            .navigationBarItems(
                trailing: Button("Kaydet") {
                    if let current = Double(currentNet),
                       let target = Double(targetNet) {
                        let progress = SubjectProgress(
                            subject: subject,
                            currentNet: current,
                            targetNet: target,
                            maxNet: 40 // Ders için maksimum net
                        )
                        viewModel.addProgress(progress)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            )
        }
    }
}

struct Resource: Codable {
    let name: String
    let type: String
    let publisher: String
    let rating: Double
    let reviews: Int
    let price: String
    let learningStyle: String
}

struct ResourceRowView: View {
    let resource: Resource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(resource.name)
                    .font(.headline)
                Spacer()
                Text(resource.price)
                    .foregroundColor(.blue)
            }
            
            HStack {
                Text(resource.publisher)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text(String(format: "%.1f", resource.rating))
                    Text("(\(resource.reviews))")
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Text(resource.type)
                    .font(.caption)
                    .padding(4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
                
                Text(resource.learningStyle)
                    .font(.caption)
                    .padding(4)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ResourceView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceView()
    }
} 
