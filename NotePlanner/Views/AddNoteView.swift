//
//  AddNoteView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/18/24.
//

import SwiftUI
import SwiftData


struct AddNoteView: View {
    //MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let notePlan: NotePlan
    @State private var text = ""
    @State private var titleOfNote = ""
  
   
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                TextField("Title:", text: $titleOfNote)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.top, 15)
                Divider()
                Text("Note:")
                    .foregroundColor(Color.secondary)
                    .fontWeight(.bold)
                    .font(.custom("HelveticaNeue", size: 18))
                    .padding(.horizontal)
                TextEditor(text: $text)
                    .foregroundColor(Color.secondary)
                    .font(.custom("HelveticaNeue", size: 18))
                    .lineSpacing(5)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        HapticManager.notification(type: .success)
                        dismiss()
                    }.buttonStyle(.bordered)
                }
                ToolbarItem(placement: .principal) {
                    Text("New Note")
                        .foregroundStyle(.primary)
                        .fontWeight(.bold)
                        .font(.custom("HelveticaNeue", size: 22))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let note = titleOfNote.isEmpty ? Note(text: text) : Note(text: text, titleOfNote: titleOfNote)
                        notePlan.notes?.append(note)
                        titleOfNote = ""
                        text = ""
                        HapticManager.notification(type: .success)
                        dismiss()
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}


    #if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    #endif
