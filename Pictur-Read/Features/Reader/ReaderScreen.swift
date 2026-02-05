//
//  ReaderScreen.swift
//  Pictur-Read
//
//  Created by Antoine Edwards on 2/5/26.
//


import SwiftUI
import PDFKit

struct ReaderScreen: View {
    let book: Book
    @State private var paragraphs: [String] = []
    @State private var isLoading = true
    
    // AI Engines
    private let analyzer = TextAnalyzer()
    private let generator = ImageGenerator()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                if isLoading {
                    ProgressView("Opening your story...")
                        .padding(.top, 50)
                } else {
                    ForEach(paragraphs.indices, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 15) {
                            // 1. The Text
                            Text(paragraphs[index])
                                .font(.custom("Georgia", size: 20)) // Classic book font
                                .lineSpacing(8)
                            
                            // 2. The Logic: Should we show an image here?
                            // For the MVP, let's show an image after every 3 paragraphs
                            if index % 3 == 0 && index != 0 {
                                IllustrationCard(paragraph: paragraphs[index], book: book)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadBookContent()
        }
    }
    
    private func loadBookContent() {
        guard let data = book.securityBookmark else { return }
        // Run extraction in the background
        Task {
            let extracted = DocumentParser.extractText(from: data)
            await MainActor.run {
                self.paragraphs = extracted
                self.isLoading = false
            }
        }
    }
}