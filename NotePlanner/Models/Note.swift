//
//  Note.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/16/24.
//

import Foundation
import SwiftData


@Model
class Note {
    
    var creationDate: Date = Date.now
    var titleOfNote: String?
    var text: String = ""
    init(
        creationDate: Date = Date.now,
        text: String,
        titleOfNote: String? = nil
    ) {
        self.creationDate = creationDate
        self.text = text
        self.titleOfNote = titleOfNote
    }
    
    var notePlan: NotePlan?
}
