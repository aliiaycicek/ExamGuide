//
//  InputView.swift
//  ExamGuide
//
//  Created by Ali Ayçiçek on 4.01.2025.
//
import SwiftUI

struct InputView: View {
    @State private var examType: String = ""
    @State private var level: String = ""
    @State private var goal: String = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.5)]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Bilgilerinizi Giriniz")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                TextField("Sınav Türü (Örn: YKS, KPSS)", text: $examType)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                TextField("Seviyeniz (Örn: Başlangıç, Orta)", text: $level)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                TextField("Hedefiniz (Örn: Tıp Fakültesi)", text: $goal)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)

                NavigationLink(destination: ResultView(examType: examType, level: level, goal: goal)) {
                    Text("Kaynakları Gör")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
            }
            .padding()
        }
        .navigationTitle("Veri Girişi")
    }
}
