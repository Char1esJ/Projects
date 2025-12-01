//
//  DetailsView.swift
//  AssignmentN38
//
//  Created by Charles Janjgava on 11/28/25.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: TimerViewModel
    @StateObject var detailsViewModel = DetailsViewModel()
    
    var body: some View {
        ZStack {
            Color.HF.opacity(0.9)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                TitleView(title: viewModel.timerModel.title)
                
                TimerLength(time: viewModel.formatTime(viewModel.timerModel.totalSeconds))
                
                timers
            }
        }
    }
    
    var timers: some View {
        VStack(alignment: .leading, spacing: 0) {
            HistoryView()
            VStack(spacing: 16) {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.elapsedTimes.indices, id: \.self) { index in
                            HStack {
                                Text(detailsViewModel.formatDate(viewModel.elapsedDates[index]))
                                Spacer()
                                Text(viewModel.formatTime(viewModel.elapsedTimes[index]))
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 30)
                        }
                    }
                }
            }
        }
        .background(Color.HF.opacity(0.9))
        .cornerRadius(20)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct TimerLength: View {
    var time: String
    var body: some View {
        VStack(spacing: 20) {
            Image("timer")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
            
            Text("Duration")
                .font(.title3)
                .foregroundColor(.white)
            
            Text(time)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 80)
        .background(.HF.opacity(0.9))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct TitleView: View {
    var title: String
    var body: some View {
        ZStack(alignment: .center) {
            Color.HF.opacity(0.9)
                .ignoresSafeArea(edges: .top)
            
            Text(title)
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .padding(.top, -50)
        }
        .frame(height: 1)
    }
}

struct HistoryView: View {
    var body: some View {
        
        Text("Activity History")
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.white)
            .padding(.top, 24)
            .padding(.leading, 24)
            .padding(.bottom, 16)
        Rectangle()
            .frame(height: 2)
            .foregroundColor(Color.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
        HStack {
            Text("Date")
                .font(.system(size: 16))
                .foregroundColor(.white)
            Spacer()
            Text("Time")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 80, alignment: .leading)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
    }
}
