//
//  FooterSection.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import SwiftUI

struct FooterSection: View {
    @ObservedObject var viewModel: ContentViewModel
    @State var name: String = ""
    @State var hour: String = ""
    @State var minute: String = ""
    @State var second: String = ""
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 11) {
            
            CustomTextField(text: $name, placeholder: "Timer name...", alignment: .leading)
                .padding(.top, 50)
                .padding([.leading, .trailing], 20)
            
            HStack(spacing: 10) {
                CustomTextField(text: $hour, placeholder: "Hour")
                CustomTextField(text: $minute, placeholder: "Minute")
                CustomTextField(text: $second, placeholder: "Second")
            }
            .padding(.horizontal, 20)
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .padding(.vertical, -7)
            }
            
            ActionButton(text: "Add", color: .blue, paddingLead: 35, paddingTrail: 35, paddingBottom: 40, fontSize: .callout,) {
                
                hideKeyboard()
                
                errorMessage = ""
                
                let timerName = name.isEmpty ? "Timer" : name
                
                let formattedTime = viewModel.formatTextFieldTime(hour: hour, minute: minute, second: second)
                let totalSeconds = viewModel.convertToSeconds(hour: hour, minute: minute, second: second)
                
                guard totalSeconds > 0 else {
                    errorMessage = "Enter the Time!"
                    return
                }
                
                let timer = TimerViewModel(timerModel: TimerModel(title: timerName, time: formattedTime, totalSeconds: totalSeconds))
                viewModel.timers.append(timer)
                
                viewModel.saveTimers()
                
                name = ""
                hour = ""
                minute = ""
                second = ""
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: 160)
        .background(Color.HF.opacity(0.8))
    }
}
