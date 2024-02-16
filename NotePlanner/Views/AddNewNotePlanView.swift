//
//  AddNewNotePlanView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/13/24.
//

import SwiftUI
import SwiftData

struct AddNewNotePlanView: View {
    //MARK:  PROPERTIES
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = " "
    @State private var subTitle = " "
    
    
    
    var body: some View {
        NavigationStack  {
            VStack {
                Form{
                    Text("Objective Title")
                        .fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    TextField("Objective Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                        .padding(.horizontal)
                    Text("Objective Description")
                        .fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    TextEditor( text: $subTitle)
                        .lineLimit(4)
                        .textEditorStyle(.automatic)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                }
            }
            .padding(.horizontal)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                            HapticManager.notification(type: .success)
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .font(.title2)
                                .foregroundStyle(.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Button {
                            HapticManager.notification(type: .success)
                        } label: {
                            HStack{
                                Image(systemName: "scope")
                                    .resizable()
                                    .font(.title2)
                                Text("Add New Objective")
                                    .fontDesign(.serif)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            HapticManager.notification(type: .success)
                            let newNotePlan = NotePlan(title: title, subTitle: subTitle)
                            context.insert(newNotePlan)
                            dismiss()                               
                            } label: {
                                Image(systemName: "square.and.arrow.down.fill")
                                    .resizable()
                                    .font(.title2)
                                    .foregroundStyle(.green)
                            }  .disabled(title.isEmpty || subTitle.isEmpty)
                    }
            }
            }
        }
    }

  
#Preview {
    AddNewNotePlanView()
}
