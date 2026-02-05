import Foundation
import ImagePlayground

struct PromptBuilder {
    static func finalizePrompt(aiDescription: String, useMemoji: Bool) -> String {
        if useMemoji {
            // Adding a specific 'Concept' tag helps the ImageCreator 
            // identify that it should look for the user's person data.
            return "A high-quality 3D illustration of [USER_MEMOJI] in this scene: \(aiDescription)"
        } else {
            return aiDescription
        }
    }
}