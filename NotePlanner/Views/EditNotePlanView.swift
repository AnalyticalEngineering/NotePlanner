//
//  EditNotePlanView.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/13/24.
//

import SwiftUI
import SwiftData

struct EditNotePlanView: View {
    //MARK:  PROPERTIES
    @Environment(\.dismiss) private var dismiss
    let notePlan: NotePlan
    @State private var status = Status.completed
    @State private var priority: Int?
    @State private var title = ""
    @State private var subTitle = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    
    
    var body: some View {
        HStack {
            GroupBox {
                HStack{
                    LabeledContent{
                        Picker("", selection: $status) {
                            ForEach(Status.allCases) { status in
                                Text(status.descr).tag(status)
                            }
                        }
                        .buttonStyle(.bordered)
                    } label: {
                        Text("Current Status")
                            .fontDesign(.serif)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
                }
                
                VStack {
                    //           GroupBox {
                    LabeledContent {
                        DatePicker("", selection: $dateAdded, displayedComponents: .date)
                    } label: {
                        Text("Date Added")
                            .fontDesign(.serif)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
                    if status == .inProcess || status == .completed {
                        LabeledContent {
                            DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                        } label: {
                            Text("Date Started")
                                .fontDesign(.serif)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                        }
                    }
                    if status == .completed {
                        LabeledContent {
                            DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                        } label: {
                            Text("Date Completed")
                                .fontDesign(.serif)
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                        }
                    }
                        }
                        .foregroundStyle(.secondary)
                        .onChange(of: status) { oldValue, newValue in
                            if !firstView {
                                if newValue == .onHold {
                                    dateStarted = Date.distantPast
                                    dateCompleted = Date.distantPast
                                } else if newValue == .inProcess && oldValue == .completed {
                                    // from completed to inProgress
                                    dateCompleted = Date.distantPast
                                } else if newValue == .inProcess && oldValue == .design{
                                    // Note has been started
                                    dateStarted = Date.now
                                } else if newValue == .completed && oldValue == .design {
                                    // Forgot to start Note
                                    dateCompleted = Date.now
                                    dateStarted = dateAdded
                                } else {
                                    // completed
                                    dateCompleted = Date.now
                                }
                                firstView = false
                            }
                        }
                    Divider()
                    LabeledContent {
                        PriorityView(maxRating: 5, currentRating: $priority, width: 30)
                    } label: {
                        Text("Priority")
                            .fontDesign(.serif)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
                    LabeledContent {
                        TextField("", text: $title)
                    } label: {
                        Text("Title").fontDesign(.serif)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
                    LabeledContent {
                        TextField("", text: $subTitle)
                    } label: {
                        Text("Description").fontDesign(.serif)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    }
                    Divider()
                    Text("Notes:").fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    TextEditor(text: $summary)
                        .padding(5)
                    
                }
            .padding(.horizontal)
                .textFieldStyle(.roundedBorder)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if changed {
                        Button("Update") {
                            notePlan.status = status.rawValue
                            notePlan.priority = priority
                            notePlan.title = title
                            notePlan.subTitle = subTitle
                            notePlan.summary = summary
                            notePlan.dateAdded = dateAdded
                            notePlan.dateStarted = dateStarted
                            notePlan.dateCompleted = dateCompleted
                            dismiss()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .onAppear {
                    
                    priority = notePlan.priority
                    title = notePlan.title
                    subTitle = notePlan.subTitle
                    summary = notePlan.summary
                    dateAdded = notePlan.dateAdded
                    dateStarted = notePlan.dateStarted
                    dateCompleted = notePlan.dateCompleted
                }
            }
        }
    var changed: Bool {
        status != Status(rawValue: notePlan.status)
        || priority != notePlan.priority
        || title != notePlan.title
        || subTitle != notePlan.subTitle
        || summary != notePlan.summary
        || dateAdded != notePlan.dateAdded
        || dateStarted != notePlan.dateStarted
        || dateCompleted != notePlan.dateCompleted
    }
}
  
