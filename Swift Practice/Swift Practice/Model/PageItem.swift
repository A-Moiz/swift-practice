//
//  PageItem.swift
//  Swift Practice
//
//  Created by Abdul Moiz on 26/09/2026.
//

import Foundation

struct PageItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let destination: AppDestination
}
