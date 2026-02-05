//
//  BookCard.swift
//  Pictur-Read
//
//  Created by Antoine Edwards on 2/5/26.
//


import SwiftUI

struct BookCard: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            // Placeholder for the "Cover"
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 200)
                .overlay(
                    Image(systemName: "book.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.8))
                )
            
            Text(book.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(book.author)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}