//
//  Book.swift
//  Pictur-Read
//
//  Created by Antoine Edwards on 2/1/26.
//

import Foundation
import SwiftData

@Model
final class Book {
    var title: String
    var bookmarkData: Data
    var importDate: Date

    init(title: String, bookmarkData: Data, importDate: Date) {
        self.title = title
        self.bookmarkData = bookmarkData
        self.importDate = importDate
    }
}
