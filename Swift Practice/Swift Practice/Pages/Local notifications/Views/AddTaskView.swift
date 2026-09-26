//
//  AddTaskView.swift
//  Swift Practice
//
//  Created by Abdul Moiz on 26/09/2026.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    var onSave: (Task) -> Void
    @State private var title = ""
    @State private var hasReminder = false
    @State private var reminderDate = Date()
    @State private var statusMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Task title", text: $title)

                Toggle("Remind me", isOn: $hasReminder)

                if hasReminder {
                    DatePicker(
                        "Reminder time",
                        selection: $reminderDate,
                        in: Date()...,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
                
                if !statusMessage.isEmpty {
                    Text(statusMessage)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let task = Task(
                            title: title,
                            hasReminder: hasReminder,
                            reminderDate: hasReminder ? reminderDate : nil
                        )
                        onSave(task)
                        
                        if hasReminder {
                            scheduleNotification(at: reminderDate)
                        }

                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    // MARK: - Scheduling notification
    func scheduleNotification(at date: Date) {
        /// Content for Notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "This is your reminder for your Task."
        content.sound = .default
        
        /// Get date components for Notification
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: date
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        /// Create Notification request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        /// Status message
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                statusMessage = "Error: \(error.localizedDescription)"
            } else {
                statusMessage = "Task reminder scheduled for \(date.formatted(date: .abbreviated, time: .shortened))"
            }
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            print("Pending: \(requests.count)")
        }
    }
}

#Preview {
    AddTaskView { task in
        print("Preview saved task: \(task)")
    }
}
