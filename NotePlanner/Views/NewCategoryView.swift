//
//  NewCategoryView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/17/24.
//

import SwiftData
import SwiftUI

struct NewCategoryView: View {
    @State private var name = ""
    @State private var color = Color.red
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                ColorPicker("Choose category color", selection: $color, supportsOpacity: false)
                Button("Create") {
                    let newCategory = Category(name: name, color: color.toHexString()!)
                    context.insert(newCategory)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .padding()
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewCategoryView()
}
