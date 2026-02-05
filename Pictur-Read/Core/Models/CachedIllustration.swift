import Foundation
import SwiftData

@Model
final class CachedIllustration {
    // 1. Identification
    var id: UUID = UUID()
    var dateCreated: Date = Date()
    
    // 2. The Logic Link
    // We store a 'hash' of the paragraph text. 
    // If the user reads the same paragraph later, we check if this hash exists in the DB.
    var textHash: String 
    
    // 3. The File Link
    // We store the filename of the image saved in the app's hidden documents folder.
    var imageFileName: String 
    
    // 4. Metadata
    var artStyle: String // e.g., "Sketch", "Illustration"
    var wasMemojiUsed: Bool
    
    // 5. Relationship back to the Book
    var book: Book?

    init(textHash: String, imageFileName: String, artStyle: String, wasMemojiUsed: Bool) {
        self.textHash = textHash
        self.imageFileName = imageFileName
        self.artStyle = artStyle
        self.wasMemojiUsed = wasMemojiUsed
    }
}