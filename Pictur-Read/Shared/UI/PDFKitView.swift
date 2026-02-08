import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        
        // Settings for a great reading experience
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        
        // Load the document from the secure URL
        pdfView.document = PDFDocument(url: url)
        
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // We leave this empty unless we want to programmatically 
        // scroll or change the document later.
    }
}