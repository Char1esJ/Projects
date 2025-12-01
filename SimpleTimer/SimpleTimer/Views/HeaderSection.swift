//
//  HeaderSection.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import SwiftUI

struct HeaderSection: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.HF.opacity(0.8))
                .ignoresSafeArea()
            Text("Timers")
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .padding(.leading, 20)
        }
        .frame(maxHeight: 70)
    }
}
