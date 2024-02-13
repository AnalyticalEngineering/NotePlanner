//
//  NotePlan.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/12/24.
//

import Foundation
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
        status: Status = .onShelf
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
    
    enum Status: Int, Codable, Identifiable, CaseIterable {
        case onShelf, inProcess, completed, proto, planning, validating, onHold, review
        var id: Self {
            self
        }
        var descr: LocalizedStringResource {
            switch self {
            case .onShelf:
                "On Shelf"
            case .inProcess:
                "In Process"
            case .completed:
                "Completed"
            case .proto:
                "Proto Type"
            case .validating:
                "Validating"
            case .review:
                "After Action Review"
            case .onHold:
                "Objective on Hold"
            case .planning:
                "Planning"
            }
        }
    }
    
}


