//
//  HideKeyboard.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/25/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
