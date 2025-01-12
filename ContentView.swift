//
//  ContentView.swift
//  ExamGuide
//
//  Created by Ali Ayçiçek on 4.01.2025.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("ExamGuide Hoş Geldiniz!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
             
                NavigationLink(destination: HomeView()) {
                    Text("HomeView'e Git")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
     
                NavigationLink(destination: InputView()) {
                    Text("InputView'e Git")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
         
                NavigationLink(destination: ResultView(examType: "Matematik", level: "Orta", goal: "Başarı")) {
                    Text("ResultView'e Git")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                .padding()
            }
        }
    }
    
}
