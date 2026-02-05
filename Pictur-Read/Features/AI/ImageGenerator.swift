import Foundation
import ImagePlayground // The 2026 Generative Image Framework

class ImageGenerator {
    private let creator = ImageCreator()

    func generateIllustration(prompt: String, style: ImagePlaygroundStyle) async -> URL? {
        // 1. Configure the request
        var configuration = ImageCreator.Configuration()
        configuration.style = style // e.g., .sketch, .illustration, .animation
        
        do {
            // 2. Generate the image
            // This returns a URL to a temporary file on the device
            let result = try await creator.generate(prompt: prompt, configuration: configuration)
            
            // 3. We return the local URL so we can move it to our cache later
            return result.url
        } catch {
            print("Image generation failed: \(error)")
            return nil
        }
    }
}