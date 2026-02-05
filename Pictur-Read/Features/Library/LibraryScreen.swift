//
//  LibraryScreen.swift
//  Pictur-Read
//
//  Created by Antoine Edwards on 2/5/26.
//


import SwiftUI
import SwiftData

struct LibraryScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    // This is like a live-updating 'useEffect' that fetches your books
    @Query(sort: \Book.dateImported, order: .reverse) private var books: [Book]
    
    @State private var searchText = ""
    @State private var isImporting = false
    
    // Define the grid layout for iPad (3 columns)
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if books.isEmpty {
                    ContentUnavailableView(
                        "No Books Yet",
                        systemImage: "books.vertical",
                        description: Text("Tap the + button to import a PDF or EPUB.")
                    )
                } else {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(filteredBooks) { book in
                            // Clicking a book navigates to the Reader
                            NavigationLink(destination: Text("Reader View for \(book.title)")) {
                                BookCard(book: book)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("My Library")
            .searchable(text: $searchText, prompt: "Search your books...")
            .toolbar {
                Button { isImporting = true } label: {
                    Image(systemName: "plus.circle.fill").font(.title2)
                }
            }
            .fileImporter(
                isPresented: $isImporting,
                allowedContentTypes: [.pdf], // Start with PDF for simplicity
                allowsMultipleSelection: false
            ) { result in
                processImport(result: result)
            }
        }
    }
    
    // Logic to filter books based on search bar
    var filteredBooks: [Book] {
        if searchText.isEmpty { return books }
        return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    private func processImport(result: Result<[URL], Error>) {
        // We'll call the SecurityBookmarks helper we wrote earlier here!
        if case .success(let urls) = result, let url = urls.first {
            do {
                let bookmark = try SecurityBookmarks.createBookmark(for: url)
                let newBook = Book(title: url.deletingPathExtension().lastPathComponent, bookmark: bookmark)
                modelContext.insert(newBook)
            } catch {
                print("Import error: \(error)")
            }
        }
    }
}