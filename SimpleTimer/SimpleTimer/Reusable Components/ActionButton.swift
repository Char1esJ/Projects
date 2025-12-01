//
//  ActionButton.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import SwiftUI

struct ActionButton: View {
    var text: String
    var color: Color
    var paddingLead: CGFloat = 20
    var paddingTrail: CGFloat = 20
    var paddingBottom: CGFloat = 20
    var fontSize: Font = .body
    var action: ()->()
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundStyle(.white)
                .font(fontSize)
                .padding(EdgeInsets(top: 10, leading: paddingLead, bottom: 10, trailing: paddingTrail))
                .background(
                    Rectangle()
                        .fill(color)
                        .cornerRadius(8)
                )
                .padding(.bottom, paddingBottom)
        }
    }
}
