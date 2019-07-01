//
//  ElevatorDetailViewModel.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

protocol ElevatorDetailViewModelDelegate: class {
    
}

final class ElevatorDetailViewModel {
    weak var delegate: ElevatorDetailViewModelDelegate?
    
    let elevator: ElevatorModel
    
    init(elevator: ElevatorModel, delegate: ElevatorDetailViewModelDelegate?) {
        self.delegate = delegate
        self.elevator = elevator
    }
}
