//
//  TimerItemViewModel.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/25/25.
//

import Combine
import Foundation
import AVFoundation

class TimerViewModel: ObservableObject, Identifiable {
    let id = UUID()
    var timerModel: TimerModel
    var timer: Timer?
    
    @Published var remainingTime: Int
    @Published var isTimerRunning: Bool = false
    @Published var elapsedTime: Int = 0
    @Published var elapsedTimes: [Int] = []
    @Published var elapsedDates: [Date] = []
    
    init(timerModel: TimerModel) {
        self.timerModel = timerModel
        self.remainingTime = timerModel.totalSeconds
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.elapsedTime += 1
            } else {
                self.timerFinished()
                
            }
        }
    }
    
    func timerFinished() {
        isTimerRunning = false
        playNotification(code: 1328)
        elapsedTimes.append(elapsedTime)
        elapsedDates.append(Date())        
        elapsedTime = 0
        timer?.invalidate()
        timer = nil
    }
   
    func stopTimer() {
        isTimerRunning = false
        if elapsedTime != 0 {
            elapsedTimes.append(elapsedTime)
            elapsedDates.append(Date())

        }

        elapsedTime = 0
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        remainingTime = timerModel.totalSeconds
        elapsedTime = 0
    }
    
    func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
    
    func playNotification(code: Int) {
        AudioServicesPlaySystemSound(SystemSoundID(code))
    }
    
}
