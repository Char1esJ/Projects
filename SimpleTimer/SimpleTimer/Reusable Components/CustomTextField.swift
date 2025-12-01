//
//  CustomTextField.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    var alignment: Alignment = .center
    var placeholderColor: Color = .white.opacity(0.3)
    
    var body: some View {
        ZStack(alignment: alignment) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(placeholderColor)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: alignment)
            }
            
            TextField(placeholder, text: $text)
                .multilineTextAlignment({
                    switch alignment {
                    case .leading:  return .leading
                    case .trailing: return .trailing
                    default:        return .center
                    }
                }())
                .foregroundStyle(.white)
                .font(.footnote)
                .monospacedDigit()
                .textFieldStyle(.plain)
        }
        .padding(10)
        .background(Color.textfield)
        .cornerRadius(8)
    }
}
