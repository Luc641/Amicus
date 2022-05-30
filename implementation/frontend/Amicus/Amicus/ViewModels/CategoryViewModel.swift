//
//  CategoryViewModel.swift
//  Amicus
//
//  Created by Nils Theres on 27.05.22.
//

import Foundation
import SwiftUI


class CategoryViewModel: ObservableObject {
    @Published var selection = Category(id: 0, categoryName: "placeholder")
    @Published var categories = [Category]()
    
    @MainActor func populateCategories() {
        Task {
            do {
                categories = try await WebClient.standard.retrieveCategories()
            } catch {}
        }
    }
}
