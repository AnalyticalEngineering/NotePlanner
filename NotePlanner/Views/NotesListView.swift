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
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let notePlan: NotePlan
    @State private var text = ""
    @State private var titleOfNote = ""
    @State private var selectedNote: Note?
    var isEditing: Bool {
        selectedNote != nil
    }
    
    var body: some View {
        NavigationStack{
            GroupBox{
                VStack{
                    HStack {
                        TextField("Title:", text: $titleOfNote)
                            .font(.custom("HelveticaNeue", size: 18))
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .frame(width: 300)
                        Spacer()
                    }
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.top, 15)
                    
                    TextEditor(text: $text)
                        .foregroundColor(Color.gray)
                        .font(.custom("HelveticaNeue", size: 18))
                        .lineSpacing(5)
                        .border(Color.secondary)
                        .frame(height: 150)
                    
                }
                List {
                    let sortedNotes = notePlan.notes?.sorted(using: KeyPathComparator(\Note.creationDate)) ?? []
                    ForEach(sortedNotes) { note in
                        VStack(alignment: .leading) {
                            Text(note.creationDate, format: .dateTime.month().day().year())
                                .fontDesign(.serif)
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.blue)
                            if let titleOfNote = note.titleOfNote, !titleOfNote.isEmpty {
                                Text("Title: \(titleOfNote)")
                                    .font(.title3)
                                    .fontDesign(.serif)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                            }
                            Text(note.text)
                                .fontDesign(.serif)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        }
                        .contentShape(RoundedRectangle(cornerRadius: 12.0))
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        HapticManager.notification(type: .success)
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem( placement: .topBarTrailing) {
                    if isEditing {
                        Button("Cancel") {
                            titleOfNote = ""
                            text = ""
                            selectedNote = nil
                            HapticManager.notification(type: .success)
                            hideKeyboard()
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    }
                }
                ToolbarItem( placement: .topBarTrailing) {
                    Button(isEditing ? "Update" : "Save") {
                        if isEditing {
                            selectedNote?.text = text
                            selectedNote?.titleOfNote = titleOfNote.isEmpty ? nil : titleOfNote
                            titleOfNote = ""
                            text = ""
                            selectedNote = nil
                            HapticManager.notification(type: .success)
                            hideKeyboard()
                        } else {
                            let note = titleOfNote.isEmpty ?
                            Note( text: text) : Note(text: text, titleOfNote: titleOfNote)
                            notePlan.notes?.append(note)
                            text = ""
                            titleOfNote = ""
                            HapticManager.notification(type: .success)
                            hideKeyboard()
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .disabled(text.isEmpty)
                }
            }
        }
    }
}
#Preview {
    let preview = Preview(NotePlan.self)
    let notePlans = NotePlan.sampleNotePlans
    preview.addExamples(notePlans)
    return NavigationStack {
        NotesListView(notePlan: notePlans[4])
            .navigationBarTitleDisplayMode(.inline)
            .modelContainer(preview.container)
    }
}
