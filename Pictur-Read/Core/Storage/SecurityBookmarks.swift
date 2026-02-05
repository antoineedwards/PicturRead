//
//  BookmarkError.swift
//  Pictur-Read
//
//  Created by Antoine Edwards on 2/5/26.
//


import Foundation

enum BookmarkError: Error {
    case permissionDenied
    case creationFailed
}

struct SecurityBookmarks {
    /// Converts a file URL from the picker into a permanent "Key" we can store in the database.
    static func createBookmark(for url: URL) throws -> Data {
        // Gain temporary access to start the process
        guard url.startAccessingSecurityScopedResource() else {
            throw BookmarkError.permissionDenied
        }
        
        // Ensure we stop accessing even if it fails
        defer { url.stopAccessingSecurityScopedResource() }
        
        do {
            return try url.bookmarkData(
                options: .minimalBookmark,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
        } catch {
            throw BookmarkError.creationFailed
        }
    }
}