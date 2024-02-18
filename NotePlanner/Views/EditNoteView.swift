//
//  EditNoteView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/18/24.
//

import SwiftUI

struct EditNoteView: View {
    //MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let note: Note
    @State private var text = ""
    @State private var titleOfNote = ""
    @State private var selectedNote: Note?
    init(note: Note) {
        self.note = note
     
    }
    var body: some View {
        NavigationStack{
                VStack{
                    LabeledContent {
                        TextField("", text: $titleOfNote)
                    } label: {
                        Text("Title").foregroundStyle(.secondary)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .padding(.top, 15)
                    }
                    Text("Note:")
                        .fontWeight(.bold)
                        .font(.custom("HelveticaNeue", size: 16))
                        .foregroundStyle(.secondary)
                    TextEditor(text: $text)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                }
                .foregroundStyle(.primary)
                .navigationTitle(titleOfNote)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        if changed {
                            Button("Update") {
                                note.titleOfNote = titleOfNote
                                note.text = text
                                dismiss()
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
                .onAppear {
                    titleOfNote = note.titleOfNote ?? ""
                    text = note.text
                }
            }
        }
    var changed: Bool {
         titleOfNote != note.titleOfNote
        || text != note.text
    }
    }

