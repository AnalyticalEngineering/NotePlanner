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
           Form{
                Section("Objective Name") {
                    TextField("Objective Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Section("Objective Summary"){
                    TextEditor( text: $subTitle)
                        .frame(width: 350, height: 200)
                       
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                        HapticManager.notification(type: .success)
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .font(.title2)
                            .foregroundStyle(.red)
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
