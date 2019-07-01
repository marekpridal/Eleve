//
//  AppCoordinator.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
import UIKit

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
        
        showMapView()
    }
    
    func showMapView() {
        let mapViewController = MapViewController()
        rootViewController.pushViewController(mapViewController, animated: true)
    }
    
    static func startApplicationCoordinator(window: UIWindow) -> ApplicationCoordinator {
        let applicationCoordinator = ApplicationCoordinator(window: window, rootViewController: UINavigationController())
        applicationCoordinator.start()
        return applicationCoordinator
    }
}
