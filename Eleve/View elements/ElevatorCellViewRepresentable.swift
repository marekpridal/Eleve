//
//  ElevatorCellViewRepresentable.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import SwiftUI

final class ElevatorCellViewRepresentable: NSObject, UIViewRepresentable {
    
    let elevator: ElevatorModel
    
    init(elevator: ElevatorModel) {
        self.elevator = elevator
    }

    func makeUIView(context: Context) -> UIElevatorCellView {
        let elevatorCellView = UIElevatorCellView()
        elevatorCellView.setup(elevator: elevator)
        return elevatorCellView
    }
    
    func updateUIView(_ view: UIElevatorCellView, context: Context) {
        view.setup(elevator: elevator)
    }
}
