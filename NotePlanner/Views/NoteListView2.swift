//
//  NoteListView2.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/18/24.
//

import SwiftUI
import SwiftData



struct NoteListView2: View {
    //MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var createNewNote: Bool = false
    @Query private var notes: [Note]
    
    let notePlan: NotePlan
    var body: some View {
        NavigationStack {
            VStack{
                List {
                    let sortedNotes = notePlan.notes?.sorted(using: KeyPathComparator(\Note.creationDate)) ?? []
                    ForEach(sortedNotes) { note in
                        NavigationLink{
                            EditNoteView(note: note)
                        } label: {
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
                        }
                    }         
                }
                .listStyle(.plain)
            }
            //MARK:  TOOLBAR
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        HapticManager.notification(type: .success)
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }.buttonStyle(.bordered)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        HapticManager.notification(type: .success)
                        createNewNote = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
            .sheet(isPresented: $createNewNote) {
                AddNoteView(notePlan: notePlan)
            }
            .presentationDetents([.height(300)])
            .navigationTitle("Notes")
        }
    }
}

