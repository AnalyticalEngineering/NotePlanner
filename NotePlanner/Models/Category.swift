//
//  Category.swift
//  NotePlanner
//
//  Created by J. DeWeese on 2/17/24.
//

import SwiftUI
import SwiftData


@Model
class Category {
    var name: String = ""
    var color: String = "FF0000"
    var notePlans: [NotePlan]?
    init(
        name: String,
        color: String
    ) {
        self.name = name
        self.color = color
    }
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}
