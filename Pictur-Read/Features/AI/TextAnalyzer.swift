import Foundation
import FoundationModels // The 2026 Apple Intelligence Framework

@MainActor
class TextAnalyzer {
    // Access the on-device language model
    private let model = LanguageModel.shared 

    func createVisualPrompt(from paragraph: String, isMemojiEnabled: Bool) async -> String {
        // 1. Create the 'System Instruction'
        let systemPrompt = """
        You are a visual scene extractor for a children's book. 
        Read the paragraph and describe one clear, beautiful visual scene.
        Be descriptive but concise. Focus on colors, environment, and characters.
        """
        
        // 2. Adjust the prompt if they want to be the hero
        let userInstruction = isMemojiEnabled 
            ? "Describe this scene. Use 'the protagonist' for the main character: \(paragraph)"
            : "Describe this scene: \(paragraph)"

        do {
            // 3. Call the On-Device LLM
            let response = try await model.generate(
                prompt: userInstruction,
                systemPrompt: systemPrompt
            )
            return response.text
        } catch {
            print("AI Analysis failed: \(error)")
            return "A simple illustration of a story scene."
        }
    }
}