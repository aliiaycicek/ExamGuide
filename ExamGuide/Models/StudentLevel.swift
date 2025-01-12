import Foundation

enum StudentLevel: String {
    case beginner = "Temel"
    case intermediate = "Orta"
    case advanced = "İleri"
    
    static func calculateLevel(currentNet: Double, targetNet: Double, maxNet: Double) -> StudentLevel {
        let performance = currentNet / maxNet
        
        switch performance {
            case 0.0..<0.4: return .beginner
            case 0.4..<0.7: return .intermediate
            default: return .advanced
        }
    }
}

struct SubjectProgress {
    let subject: String
    let currentNet: Double
    let targetNet: Double
    let maxNet: Double
    
    var level: StudentLevel {
        StudentLevel.calculateLevel(currentNet: currentNet, targetNet: targetNet, maxNet: maxNet)
    }
    
    var improvementNeeded: Double {
        targetNet - currentNet
    }
} 