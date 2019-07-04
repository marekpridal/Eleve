//
//  ReportElevatorViewModel.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

protocol ReportElevatorViewModelDelegate: class {
    func dismissReport()
}

final class ReportElevatorViewModel {
    weak var delegate: ReportElevatorViewModelDelegate?
    let elevator: ElevatorModel
    
    init(elevator: ElevatorModel, delegate: ReportElevatorViewModelDelegate?) {
        self.delegate = delegate
        self.elevator = elevator
    }
}
