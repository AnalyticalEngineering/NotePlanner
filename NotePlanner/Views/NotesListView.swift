//
//  NotesListView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/16/24.
//

import SwiftUI
import SwiftData


struct NotesListView: View {
    //MARK:  PROPERTIES
    @Environment(\.modelContext) private var modelContext
    let notePlan: NotePlan
    @State private var text = ""
    @State private var titleOfNote = ""
    @State private var selectedNote: Note?
    var isEditing: Bool {
        selectedNote != nil
    }
    
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent("Title") {
                    TextField("Title:", text: $titleOfNote)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 150)
                    Spacer()
                }
                if isEditing {
                    Button("Cancel") {
                        titleOfNote = ""
                        text = ""
                        selectedNote = nil
                    }
                    .buttonStyle(.bordered)
                }
                Button(isEditing ? "Update" : "Create") {
                    if isEditing {
                        selectedNote?.text = text
                        selectedNote?.titleOfNote = titleOfNote.isEmpty ? nil : titleOfNote
                        titleOfNote = ""
                        text = ""
                        selectedNote = nil
                    } else {
                        let note = titleOfNote.isEmpty ? Note( text: text) : Note(text: text, titleOfNote: titleOfNote)
                        notePlan.notes?.append(note)
                        text = ""
                        titleOfNote = ""
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.isEmpty)
            }
            TextEditor(text: $text)
                .border(Color.secondary)
                .frame(height: 100)
            
                .padding(.horizontal)
            List {
                let sortedNotes = notePlan.notes?.sorted(using: KeyPathComparator(\Note.creationDate)) ?? []
                ForEach(sortedNotes) { note in
                    VStack(alignment: .leading) {
                        Text(note.creationDate, format: .dateTime.month().day().year())
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(note.text)
                        HStack {
                            Spacer()
                            if let titleOfNote = note.titleOfNote, !titleOfNote.isEmpty {
                                Text("Title: \(titleOfNote)")
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedNote = note
                        text = note.text
                        titleOfNote = note.titleOfNote ?? ""
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        indexSet.forEach { index in
                            let note = sortedNotes[index]
                            notePlan.notes?.forEach{ notePlanNote in
                                if note.id == notePlanNote.id {
                                    modelContext.delete(note)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            
        }
    }
}
