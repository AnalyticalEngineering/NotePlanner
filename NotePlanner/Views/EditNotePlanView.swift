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
    @State private var status = Status.Contribution
    @State private var priority: Int?
    @State private var title = ""
    @State private var subTitle = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var initiatedBy = ""
    @State private var firstView = true
    @State private var showCategories = false
    
    init(notePlan: NotePlan) {
        self.notePlan = notePlan
        _status = State(initialValue: Status(rawValue: notePlan.status)!)
    }
    var body: some View {
        HStack{
            LabeledContent{
                Picker("", selection: $status) {
                    ForEach(Status.allCases) { status in
                        Text(status.descr).tag(status)
                    }
                }
                .padding(.horizontal, 20)
                .buttonStyle(.borderedProminent)
            } label: {
                Text("Objective Category")
                    .fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)
            }
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                        .fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                }
                LabeledContent {
                    DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                } label: {
                    Text("Date Started")
                        .fontDesign(.serif)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                }
            
            LabeledContent {
                DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
            } label: {
                Text("Date Due")
                    .fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }
        }
    }
            .padding(.horizontal)
            .foregroundStyle(.secondary)
            //                .onChange(of: status) { oldValue, newValue in
            //                    if !firstView {
            //                        if newValue == .Strategize {
            //                            dateStarted = Date.distantPast
            //                            dateCompleted = Date.distantPast
            //                        } else if newValue == .Strategize && oldValue == .Contribution {
            //                            // from Contribution to inProgress
            //                            dateCompleted = Date.distantPast
            //                        } else if newValue == .Strategize && oldValue == .Strategize{
            //                            // Note has been started
            //                            dateStarted = Date.now
            //                        } else if newValue == .Contribution && oldValue == .design {
            //                            // Forgot to start Note
            //                            dateCompleted = Date.now
            //                            dateStarted = dateAdded
            //                        } else {
            //                            // Contribution
            //                            dateCompleted = Date.now
            //                        }
            //                        firstView = false
            //                    }
            //                }
            Divider()
            LabeledContent {
                //MARK:  PRIORITY VIEW
                PriorityView(maxRating: 5, currentRating: $priority, width: 30)
            } label: {
                Text("Priority")
                    .fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }.padding(.horizontal)
            
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title").fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }.padding(.horizontal)
        
            LabeledContent {
                TextField("", text: $subTitle)
            } label: {
                Text("Description").fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }.padding(.horizontal)
        
            LabeledContent {
                TextField("Initiated By", text: $initiatedBy)
            } label: {
                Text("Initiated By").fontDesign(.serif)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            //MARK:  CATEGORY SELECTION BUTTON
            if let categories = notePlan.categories {
                ViewThatFits {
                    CategoryStackView(categories: categories)
                    ScrollView(.horizontal, showsIndicators: false) {
                        CategoryStackView(categories: categories)
                    }
                }.padding(.top, 25)
            }
            HStack {
                Button("Tags", systemImage: "scope") {
                    showCategories.toggle()
                    HapticManager.notification(type: .success)
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $showCategories) {
                    CategoryView(notePlan: notePlan)
                }
                //MARK:  NOTES LINK BUTTON
                NavigationLink {
                    NotesListView(notePlan: notePlan)
                } label: {
                    let count = notePlan.notes?.count ?? 0
                    Label("^[\(count) Notes](inflect: true)", systemImage: "pencil.and.outline")
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            //MARK:  TOOLBAR
            Spacer()
                .toolbar {
                    if changed {
                        Button("Update") {
                            notePlan.status = status.rawValue
                            notePlan.priority = priority
                            notePlan.title = title
                            notePlan.subTitle = subTitle
                            notePlan.summary = summary
                            notePlan.initiatedBy = initiatedBy
                            notePlan.dateAdded = dateAdded
                            notePlan.dateStarted = dateStarted
                            notePlan.dateCompleted = dateCompleted
                            dismiss()
                            HapticManager.notification(type: .success)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .onAppear {
                    priority = notePlan.priority
                    title = notePlan.title
                    subTitle = notePlan.subTitle
                    summary = notePlan.summary
                    initiatedBy = notePlan.initiatedBy
                    dateAdded = notePlan.dateAdded
                    dateStarted = notePlan.dateStarted
                    dateCompleted = notePlan.dateCompleted
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
                        || initiatedBy != notePlan.initiatedBy
            }
        }
#Preview {
    let preview = Preview(NotePlan.self)
   return  NavigationStack {
       EditNotePlanView(notePlan: NotePlan.sampleNotePlans[4])
           .modelContainer(preview.container)
    }
}
