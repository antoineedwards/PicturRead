import SwiftUI

struct IllustrationCard: View {
    let paragraph: String
    let book: Book
    
    @State private var image: UIImage? = nil
    @State private var isGenerating = false
    
    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            } else if isGenerating {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.secondary.opacity(0.2))
                    .frame(height: 250)
                    .overlay(ProgressView("AI is imagining..."))
            } else {
                // Button to manually trigger if it's not cached
                Button("Visualize Scene") {
                    generateImage()
                }
                .buttonStyle(.bordered)
            }
        }
        .onAppear {
            checkCache()
        }
    }
    
    private func checkCache() {
        // Logic to check FileManager for existing image based on text hash
    }
    
    private func generateImage() {
        isGenerating = true
        Task {
            // 1. Get visual description from LLM
            // 2. Generate Image
            // 3. Save to FileManager
            // 4. Update UI
            isGenerating = false
        }
    }
}