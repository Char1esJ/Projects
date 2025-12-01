//
//  ContentViewModel.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var timers: [TimerViewModel] = []
    
    private let userDefaultsKey = "savedTimers"
    
    init() {
        loadTimers()
    }
    
    func deleteTimer(id: UUID) {
        timers.removeAll { $0.id == id }
        saveTimers()
    }
    
    func saveTimers() {
        let models = timers.map { $0.timerModel }
        
        if let encoded = try? JSONEncoder().encode(models) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadTimers() {
        guard let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
              let models = try? JSONDecoder().decode([TimerModel].self, from: savedData) else {
            timers = [
                TimerViewModel(timerModel: TimerModel(title: "Workout", time: "00:45:00", totalSeconds: 45*60)),
                TimerViewModel(timerModel: TimerModel(title: "Meditation", time: "00:15:00", totalSeconds: 15*60))
            ]
            return
        }
        
        timers = models.map { TimerViewModel(timerModel: $0) }
    }
    
    func formatTextFieldTime(hour: String, minute: String, second: String) -> String {
        let hours = Int(hour) ?? 0
        let minutes = Int(minute) ?? 0
        let seconds = Int(second) ?? 0
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func convertToSeconds(hour: String, minute: String, second: String) -> Int {
        let hours = Int(hour) ?? 0
        let minutes = Int(minute) ?? 0
        let seconds = Int(second) ?? 0
        
        return (hours * 3600) + (minutes * 60) + seconds
    }
}
