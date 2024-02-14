//
//  ObjectivesListView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/12/24.
//

import SwiftUI
import SwiftData

struct NotePlanListView: View {
    //MARK:  PROPERTIES
    
    @State private var addNewNotePlan = false
    @Environment(\.modelContext) private var context
  @State private var filter = " "
    
    var body: some View {
        NavigationView{
            NotePlanList()
                .searchable(text: $filter, prompt: Text("Search"))
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
