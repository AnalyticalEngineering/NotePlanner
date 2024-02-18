//
//  CategoryView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/17/24.
//

import SwiftData
import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var notePlan: NotePlan
    @Query(sort: \Category.name) var categories: [Category]
    @State private var newCategory = false
    var body: some View {
        NavigationStack {
            Group {
              
                    
                    List {
                        ForEach(categories) { category in
                            HStack {
                                if let notePlanCategories = notePlan.categories {
                                    if notePlanCategories.isEmpty {
                                        Button {
                                            addRemove(category)
                                            HapticManager.notification(type: .success)
                                        } label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(category.hexColor)
                                    } else {
                                        Button {
                                            addRemove(category)
                                        } label: {
                                            Image(systemName: notePlanCategories.contains(category) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(category.hexColor)
                                    }
                                }
                                Text(category.name)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                if let notePlanCategories = notePlan.categories,
                                   notePlanCategories.contains(categories[index]),
                                   let notePlanCategoryIndex = notePlanCategories.firstIndex(where: {$0.id == categories[index].id}) {
                                    notePlan.categories?.remove(at: notePlanCategoryIndex)
                                }
                                context.delete(categories[index])
                            }
                        })
                        LabeledContent {
                            Button {
                                newCategory.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Create new Category")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
                    .navigationTitle(notePlan.title)
                    .sheet(isPresented: $newCategory) {
                        NewCategoryView()
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Back") {
                                dismiss()
                            }
                        }
                    }
            }
        }
    
    func addRemove(_ category: Category) {
        if let notePlanCategories = notePlan.categories {
            if notePlanCategories.isEmpty {
                notePlan.categories?.append(category)
            } else {
                if notePlanCategories.contains(category),
                   let index = notePlanCategories.firstIndex(where: {$0.id == category.id}) {
                    notePlan.categories?.remove(at: index)
                } else {
                    notePlan.categories?.append(category)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(NotePlan.self)
    let notePlans = NotePlan.sampleNotePlans
    let categories = Category.sampleCategories
    preview.addExamples(categories)
    preview.addExamples(notePlans)
    notePlans[1].categories?.append(categories[0])
    return CategoryView(notePlan: notePlans[1])
        .modelContainer(preview.container)
}
