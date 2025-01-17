import Foundation

class GeminiService {
    private let apiKey = "AIzaSyDapYInKXB4dNq7UB4twcKtOR12CMSW1MU"
    private let baseURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent"
    
    func analyzeStudentLevel(progress: SubjectProgress) async throws -> String {
        let prompt = """
        Bir öğrencinin \(progress.subject) dersindeki durumunu analiz et:
        - Mevcut net: \(progress.currentNet)
        - Hedef net: \(progress.targetNet)
        - Maksimum net: \(progress.maxNet)
        - Seviye: \(progress.level.rawValue)
        
        Bu öğrenci için detaylı bir analiz yap ve hangi tür kaynakları kullanması gerektiğini öner.
        """
        
        return try await makeGeminiRequest(prompt: prompt)
    }
    
    func getResourceRecommendations(progress: SubjectProgress) async throws -> [Resource] {
        let prompt = """
        \(progress.subject) dersi için kaynak önerisi yap:
        - Mevcut seviye: \(progress.level.rawValue)
        - Mevcut net: \(progress.currentNet)
        - Hedef net: \(progress.targetNet)
        
        Öğrencinin netini \(progress.targetNet) seviyesine çıkarması için en uygun kaynakları öner.
        Yanıt formatı JSON olmalı:
        [
            {
                "name": "Kaynak adı",
                "type": "Kaynak türü",
                "publisher": "Yayınevi",
                "rating": 4.5,
                "reviews": 100,
                "price": "99 TL",
                "learningStyle": "Visual/Auditory/Reading/Kinesthetic"
            }
        ]
        """
        
        let jsonString = try await makeGeminiRequest(prompt: prompt)
        return try parseResources(from: jsonString)
    }
    
    private func makeGeminiRequest(prompt: String) async throws -> String {
        let url = URL(string: "\(baseURL)?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = [
            "contents": [
                [
                    "parts": [
                        ["text": prompt]
                    ]
                ]
            ]
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Debug için yanıtı kontrol et
        if let httpResponse = response as? HTTPURLResponse {
            print("Status code: \(httpResponse.statusCode)")
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }
        
        let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
        return geminiResponse.candidates?.first?.content?.parts?.first?.text ?? "Yanıt alınamadı"
    }
    
    private func parseResources(from json: String) throws -> [Resource] {
        let data = json.data(using: .utf8)!
        return try JSONDecoder().decode([Resource].self, from: data)
    }
}

struct GeminiResponse: Codable {
    let candidates: [Candidate]?
    let promptFeedback: PromptFeedback?
}

struct PromptFeedback: Codable {
    let blockReason: String?
    let safetyRatings: [SafetyRating]?
}

struct SafetyRating: Codable {
    let category: String
    let probability: String
}

struct Candidate: Codable {
    let content: Content?
    let finishReason: String?
    let index: Int?
    let safetyRatings: [SafetyRating]?
}

struct Content: Codable {
    let parts: [Part]?
    let role: String?
}

struct Part: Codable {
    let text: String?
} 
