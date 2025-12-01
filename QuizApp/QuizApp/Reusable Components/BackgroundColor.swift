//
//  BackgroundColor.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI

struct BackgroundColor: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.gradient1,
                    Color.gradient2
                ]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
