//
//  ApplicationCoordinatorProtocol.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationCoordinatorProtocol {
    var applicationCoordinator: ApplicationCoordinator? { get set }
    var window: UIWindow? { get set }
    
    func startCoordinator(window: UIWindow)
}
