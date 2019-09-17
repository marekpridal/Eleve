//
//  AppCoordinator.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    
    fileprivate init(window: UIWindow, rootViewController: UINavigationController) {
        self.window = window
        self.rootViewController = rootViewController
    }
    
    deinit {
        print("Deinit of \(self)")
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        rootViewController.isNavigationBarHidden = true

        showMapView()
    }
    
    func showMapView() {
        let mapViewController = MapViewController(viewModel: MapViewModel(delegate: self))
        rootViewController.pushViewController(mapViewController, animated: true)
    }
    
    static func startApplicationCoordinator(window: UIWindow) -> ApplicationCoordinator {
        let applicationCoordinator = ApplicationCoordinator(window: window, rootViewController: UINavigationController())
        applicationCoordinator.start()
        return applicationCoordinator
    }
}

extension ApplicationCoordinator: MapViewModelDelegate {
    func navigate(elevator: ElevatorModel) {
        // TODO
    }
    
    func report(elevator: ElevatorModel) {
        let report = UIHostingController(rootView: ReportElevatorView(viewModel: ReportElevatorViewModel(elevator: elevator, delegate: self)))        
        rootViewController.present(UINavigationController(rootViewController: report), animated: true, completion: nil)
    }
    
    func showImageDetail(_ image: UIImage) {
        // TODO
    }
    
    func openSettings() {
        let settings = UIHostingController(rootView: SettingsView(viewModel: SettingsViewModel(delegate: self)))
        rootViewController.pushViewController(settings, animated: true)
    }
}

extension ApplicationCoordinator: ReportElevatorViewModelDelegate {
    func dismissReport() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}

extension ApplicationCoordinator: SettingsViewModelDelegate {
    
}
