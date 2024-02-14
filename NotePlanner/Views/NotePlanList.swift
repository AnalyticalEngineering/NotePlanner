//
//  NotePlanList.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/14/24.
//

import SwiftUI
import SwiftData


struct NotePlanList: View {
    // MARK: PROPERTIES
    @Environment(\.modelContext) private var context
    @Query(sort: \NotePlan.title) private var notePlans: [NotePlan]
    
    var body: some View {
        
        Group {
            List {
                ForEach(notePlans) { notePlan in
                    NavigationLink {
                        EditNotePlanView(notePlan: notePlan)
                    } label : {
                        VStack{
                            HStack (spacing: 10){
                                notePlan.icon
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.blue)
                                Text(notePlan.title)
                                    .font(.title2)
                                    .fontDesign(.serif)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                Text(notePlan.subTitle)
                                    .padding(4)
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                            }
                            .padding(.horizontal)
                            VStack{
                                HStack{
                                    if let priority = notePlan.priority {
                                        HStack{
                                            ForEach(0..<priority, id: \.self) {
                                                _ in
                                                Image(systemName: "flag.fill")
                                                    .imageScale(.medium)
                                                    .foregroundStyle(.red)
                                            }
                                        }
                                        .padding(.horizontal,2)
                                        .padding(.leading,60)
                                    }
                                    Spacer()
                                }
                            }
                        } .padding(4)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let notePlan = notePlans[index]
                        context.delete(notePlan)
                    }
                }
            }.listStyle(.plain)
        }
    }
}

#Preview {
    NotePlanList()
}