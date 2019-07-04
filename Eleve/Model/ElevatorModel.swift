//
//  ElevatorModel.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

struct ElevatorModel {
    let name: String
    let status: String
    let lastUpdate: Date
    let type: String
    let duration: TimeInterval
    
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second ]
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = [ .default ]
        return formatter.string(from: duration)!
    }
}
