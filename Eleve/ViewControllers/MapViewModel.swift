//
//  MapViewModel.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
import UIKit

protocol MapViewModelDelegate: class {
    func navigate(elevator: ElevatorModel)
    func report(elevator: ElevatorModel)
    func showImageDetail(_ image: UIImage)
    func openSettings()
}

final class MapViewModel {
    weak var delegate: MapViewModelDelegate?
    
    init(delegate: MapViewModelDelegate?) {
        self.delegate = delegate
    }
}
