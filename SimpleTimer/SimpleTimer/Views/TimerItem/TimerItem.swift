//
//  TimerItem.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import SwiftUI

struct TimerItem: View {
    @ObservedObject var viewModel: TimerViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    @State private var showAlert = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text(viewModel.timerModel.title)
                .foregroundStyle(.white)
                .font(.title2)
                .padding(.top, 22)
                .padding(.leading, 20)
            
            GeometryReader { geo in
                Text(viewModel.formatTime(viewModel.remainingTime))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.timer)
                    .position(x: geo.size.width/2, y: geo.size.height/2)
            }
            
            HStack(spacing: 10) {
                ActionButton(
                    text: viewModel.isTimerRunning ? "Pause" : "Start",
                    color: viewModel.isTimerRunning ? .orange : .green
                ) {
                    if viewModel.isTimerRunning {
                        viewModel.stopTimer()
                    } else {
                        viewModel.startTimer()
                    }
                }
                
                ActionButton(text: "Reset", color: .red) {
                    viewModel.resetTimer()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: 185, alignment: .topLeading)
        .background(Color.HF)
        .cornerRadius(16)
        .overlay(alignment: .topTrailing) {
            Button {
                showAlert = true
            } label: {
                Image("delete")
                    .resizable()
                    .frame(width: 26, height: 26)
            }
            .alert("Are you sure you want to delete?", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    contentViewModel.deleteTimer(id: viewModel.id)
                    viewModel.playNotification(code: 1156)
                    viewModel.stopTimer()
                }
            } message: {
                Text("Timer will be deleted permanently")
            }
            .buttonStyle(.plain)
            .padding(.trailing, 17)
            .padding(.top, 12)
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}
