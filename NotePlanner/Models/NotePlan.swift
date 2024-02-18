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
    var initiatedBy: String = ""
    var dateAdded: Date
    var dateStarted:  Date
    var dateCompleted: Date
    var priority: Int?
    
    var status: Status.RawValue = Status.Strategize.rawValue
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    @Relationship(inverse: \Category.notePlans)
    var categories: [Category]?
    
    
    init(
        title: String,
        subTitle: String,
        summary: String = "",
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        priority: Int? = nil,
        status: Status = .Strategize,
        initiatedBy: String = ""
        
        //non-optionals are initialized
    ) {
        self.title = title
        self.subTitle = subTitle
        self.summary = summary
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.priority = priority
        self.status = status.rawValue
        self.initiatedBy = initiatedBy
    }
    
    var icon: Image {
        switch Status(rawValue: status)!  {
            
        case .Calibrate:
            Image(systemName: "location.north")
        case .Strategize:
            Image(systemName: "compass.drawing")
        case .Knowledge:
            Image(systemName: "books.vertical.fill")
        case .Contribution:
            Image(systemName: "globe")
        case .Strength:
            Image(systemName: "figure.highintensity.intervaltraining")
       
        }
    }
}
enum Status: Int, Codable, Identifiable, CaseIterable {
        case  Strategize, Contribution,Calibrate, Knowledge, Strength
        var id: Self {
            self
        }
        var descr: LocalizedStringResource {
            switch self {
            
            case .Strategize:
                "Strategize"
            case .Contribution:
                "Contribution"
            case .Knowledge:
                "Knowledge"
            case .Strength:
                "Strength"
            case .Calibrate:
                "Calibrate"

            }
        }
    }
    



