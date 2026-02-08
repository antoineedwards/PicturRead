import Foundation
import PDFKit
import UniformTypeIdentifiers

struct DocumentParser {
    
    /// Extracts all text from a PDF given its security-scoped bookmark data.
    static func extractText(from bookmarkData: Data) -> [String] {
        var paragraphs: [String] = []
        
        // 1. Resolve the bookmark back into a real URL
        var isStale = false
        do {
            let url = try URL(resolvingBookmarkData: bookmarkData, 
                              options: .withoutUI, 
                              relativeTo: nil, 
                              bookmarkDataIsStale: &isStale)
            
            // 2. Gain temporary "Security Access" to the file
            guard url.startAccessingSecurityScopedResource() else {
                print("Permission denied to access file")
                return []
            }
            
            // 3. Ensure we stop accessing the resource when we are done
            defer { url.stopAccessingSecurityScopedResource() }
            
            // 4. Load the PDF Document
            guard let document = PDFDocument(url: url) else {
                print("Failed to load PDF document")
                return []
            }
            
            // 5. Loop through pages and extract text
            for i in 0..<document.pageCount {
                if let page = document.page(at: i), let pageText = page.string {
                    // Split the page text by double newlines or single newlines
                    let chunks = pageText.components(separatedBy: "\n")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                        .filter { $0.count > 15 } // Filter out page numbers or tiny headers
                    
                    paragraphs.append(contentsOf: chunks)
                }
            }
            
        } catch {
            print("Could not resolve bookmark: \(error.localizedDescription)")
        }
        
        return paragraphs
    }
}