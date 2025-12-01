//
//  DetailsViewModel.swift
//  AssignmentN38
//
//  Created by Charles Janjgava on 11/28/25.
//

import Foundation
import Combine

class DetailsViewModel: ObservableObject {
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
