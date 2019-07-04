//
//  SettingsViewModel.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

protocol SettingsViewModelDelegate: class { }

final class SettingsViewModel {
    weak var delegate: SettingsViewModelDelegate?
    
    init(delegate: SettingsViewModelDelegate?) {
        self.delegate = delegate
    }
}
