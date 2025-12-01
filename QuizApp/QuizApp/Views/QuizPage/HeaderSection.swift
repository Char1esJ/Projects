//
//  HeaderSection.swift
//  Assignment-N30
//
//  Created by Charles Janjgava on 11/26/25.
//

import SwiftUI

struct HeaderSection: View {
    @ObservedObject var viewModel: QuizViewModel
    
    var body: some View {
        HStack {
            Text("Question \(viewModel.questionNumber+1)")
                .foregroundStyle(.white)
                .padding(10)
                .background(
                    Capsule()
                        .fill(.capsulecolor)
                )
            Spacer()
            Text("Charles")
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: 35)
    }
}
