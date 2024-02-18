//
//  CategoryStack.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/17/24.
//

import SwiftUI

struct CategoryStackView: View {
    var categories: [Category]
    var body: some View {
        HStack {
            ForEach(categories.sorted(using: KeyPathComparator(\Category.name))) { category in
                Text(category.name)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).fill(category.hexColor))
            }
        }
    }
}
