//
//  NotePlan.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/12/24.
//

import SwiftUI
import SwiftData


@Model
class NotePlan {
    var title:  String
    var subTitle: String
    var summary: String
    var dateAdded: Date
    var dateStarted:  Date
    var dateCompleted: Date
    var priority: Int?
    var status: Status
    
    init(
        title: String,
        subTitle: String,
        summary: String = "",
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        priority: Int? = nil,
        status: Status = .design
        //non-optionals are initialized
    ) {
        self.title = title
        self.subTitle = subTitle
        self.summary = summary
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.priority = priority
        self.status = status
    }
    
    var icon: Image {
        switch status {
            
        case .planning:
            Image(systemName: "calendar.circle.fill")
        case .inProcess:
            Image(systemName: "repeat.circle.fill")
        case .validating:
            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        case .completed:
            Image(systemName: "checkmark.seal.fill")
        case .onHold:
            Image(systemName: "exclamationmark.triangle.fill")
        case .review:
            Image(systemName: "checkmark.circle.badge.questionmark")
        case .design:
            Image(systemName: "compass.drawing")
       
        }
    }
}
enum Status: Int, Codable, Identifiable, CaseIterable {
        case  inProcess, completed,planning, validating, onHold, review, design
        var id: Self {
            self
        }
        var descr: String {
            switch self {
            
            case .inProcess:
                "In Process"
            case .completed:
                "Completed"
            case .validating:
                "Validating"
            case .review:
                "After Action Review"
            case .onHold:
                "Objective on Hold"
            case .planning:
                "Planning"
            case .design:
                "Design"
            }
        }
    }
    



