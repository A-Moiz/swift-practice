//
//  TaskListView.swift
//  Swift Practice
//
//  Created by Abdul Moiz on 26/09/2026.
//

import SwiftUI
import UserNotifications

struct TaskListView: View {
    @State private var tasks: [Task] = []
    @State private var showingAddTask = false
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                VStack(alignment: .leading) {
                    Text(task.title)
                    if task.hasReminder, let date = task.reminderDate {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .onDelete { indexSet in
                tasks.remove(atOffsets: indexSet)
            }
        }
        .navigationTitle("To-Do")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showingAddTask = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView { newTask in
                tasks.append(newTask)
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    // MARK: - User permission for Notifications
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Permission error: \(error)")
            }
            print("Permission granted: \(granted)")
        }
    }
}

#Preview {
    TaskListView()
}
