import SwiftUI

struct ProgressRowView: View {
    let progress: SubjectProgress
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(progress.subject)
                    .font(.headline)
                Spacer()
                Text(progress.level.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(4)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Mevcut Net")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(String(format: "%.1f", progress.currentNet))
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Hedef Net")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(String(format: "%.1f", progress.targetNet))
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Gereken Artış")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(String(format: "+%.1f", progress.improvementNeeded))
                        .font(.subheadline)
                        .foregroundColor(progress.improvementNeeded > 0 ? .red : .green)
                }
            }
            
            ProgressView(value: progress.currentNet, total: progress.maxNet)
                .tint(.blue)
        }
        .padding(.vertical, 4)
    }
}

struct ProgressRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRowView(progress: SubjectProgress(
            subject: "Matematik",
            currentNet: 25.5,
            targetNet: 35.0,
            maxNet: 40.0
        ))
        .previewLayout(.sizeThatFits)
        .padding()
    }
} 