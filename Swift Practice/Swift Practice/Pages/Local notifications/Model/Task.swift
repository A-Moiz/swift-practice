//
//  Task.swift
//  Swift Practice
//
//  Created by Abdul Moiz on 26/09/2026.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var hasReminder: Bool
    var reminderDate: Date?
}
