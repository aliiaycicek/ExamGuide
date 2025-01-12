//
//  ResultView.swift
//  ExamGuide
//
//  Created by Ali Ayçiçek on 4.01.2025.
//
import SwiftUI
import SwiftUICore

struct ResultView: View {
    var examType: String
    var level: String
    var goal: String

    @State private var recommendedResources: [String] = []

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Önerilen Kaynaklar")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                if recommendedResources.isEmpty {
                    ProgressView("Kaynaklar yükleniyor...")
                        .onAppear {
                            fetchRecommendations()
                        }
                } else {
                    List(recommendedResources, id: \.self) { resource in
                        Text(resource)
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .padding()
        }
        .navigationTitle("Sonuçlar")
    }

    func fetchRecommendations() {
        // Örnek: Yapay zeka algoritması yerine sabit bir liste döndürüyoruz.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            recommendedResources = [
                "Matematik Soru Bankası - Orta Seviye",
                "Fizik Konu Anlatımı - Başlangıç",
                "Kimya Deneme Seti - İleri Seviye"
            ]
        }
    }
}
