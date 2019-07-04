//
//  ElevatorDetailViewModel.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
import UIKit

protocol ElevatorDetailViewModelDelegate: class {
    func dismiss()
    func navigate()
    func report()
    func showImageDetail(_ image: UIImage)
}

final class ElevatorDetailViewModel {
    weak var delegate: ElevatorDetailViewModelDelegate?
    
    let elevator: ElevatorModel
    
    init(elevator: ElevatorModel, delegate: ElevatorDetailViewModelDelegate?) {
        self.delegate = delegate
        self.elevator = elevator
    }
    
    func favorite() {
        
    }
}
