//
//  Timer.swift
//  AssignmentN29
//
//  Created by Charles Janjgava on 11/24/25.
//

import Foundation
import SwiftUI

struct TimerModel: Identifiable, Codable {
    var id = UUID()
    var title: String
    var time: String 
    var totalSeconds: Int
    var elapsedTimes: [Int] = []
    
}
