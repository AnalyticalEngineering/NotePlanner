//
//  ObjectivesListView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/12/24.
//

import SwiftUI
import SwiftData

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, subTitle
    
    var id: Self {
        self
    }
}


struct NotePlanListView: View {
    //MARK:  PROPERTIES
    @Query(sort: \NotePlan.title) private var notePlans: [NotePlan]
    @State private var addNewNotePlan = false
    @Environment(\.modelContext) private var context
  @State private var filter = " "
    @State private var sortOrder = SortOrder.status
    
  
        var body: some View {
            NavigationView{
                VStack{
                    Picker("", selection: $sortOrder) {
                        ForEach(SortOrder.allCases) { sortOrder in
                            Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    ///MARK:  NOTE PLAN LIST VIEW
                    NotePlanList(sortOrder: sortOrder, filterString: filter)
                   //     .searchable(text: $filter)
                }
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading) {
                            Button {
                                HapticManager.notification(type: .success)
                            } label: {
                                Image(systemName: "line.3.horizontal.circle.fill")
                                    .font(.title3)
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            Button {
                                HapticManager.notification(type: .success)
                            } label: {
                                HStack{
                                    Image(systemName: "scope")
                                        .resizable()
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text("bjectives")
                                        .fontDesign(.serif)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .offset(x: -8.0)
                                }.foregroundStyle(.blue)
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                HapticManager.notification(type: .success)
                                addNewNotePlan = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title3)
                            }
                        }
                    }
                    .sheet(isPresented: $addNewNotePlan) {
                        AddNewNotePlanView()
                            .presentationDetents([.medium])
                    }
            }
        }
    }
            
#Preview {
    NotePlanListView()
        .modelContainer(for: NotePlan.self, inMemory: true)
}
