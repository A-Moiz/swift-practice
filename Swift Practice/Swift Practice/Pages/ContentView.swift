//
//  ContentView.swift
//  Swift Practice
//
//  Created by Abdul Moiz on 25/09/2026.
//

import SwiftUI

enum AppDestination: Hashable {
    case localNotifications
}

struct ContentView: View {
    @State private var pages: [PageItem] = [
        PageItem(
            title: "Local Notifications",
            description: "Practicing how to trigger local notifications",
            destination: .localNotifications
        )
    ]
    @State private var selectedDescription: String?
    @State private var showInfoAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(pages) { page in
                        NavigationLink(value: page.destination) {
                            Text(page.title)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                selectedDescription = page.description
                                showInfoAlert = true
                            } label: {
                                Image(systemName: "i.circle")
                            }
                            .tint(.blue)
                        }
                    }
                }
                .listStyle(.automatic)
            }
            .navigationTitle("Home")
            .navigationDestination(for: AppDestination.self) { destination in
                switch destination {
                case .localNotifications:
                    Text("Local Notifications")
                }
            }
            .alert("Page Info", isPresented: $showInfoAlert, presenting: selectedDescription) { _ in
                Button("OK", role: .cancel) { }
            } message: { description in
                Text(description)
            }
        }
    }
}

#Preview {
    ContentView()
}
