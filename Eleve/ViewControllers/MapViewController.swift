//
//  MapViewController.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import FloatingPanel
import MapKit
import UIKit

final class MapViewController: UIViewController {
    
    private let floatingPanel = FloatingPanelController()
    private let mapView = MKMapView()
    private let searchViewController = SearchViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(mapView: mapView)
        setup(searchViewController: searchViewController)
        setup(floatingPanel: floatingPanel, searchViewController: searchViewController)
    }
    
    private func setup(mapView: MKMapView) {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
            ])
    }
    
    private func setup(searchViewController: SearchViewController) {
        searchViewController.searchBar.delegate = self
        
    }
    
    private func setup(floatingPanel: FloatingPanelController, searchViewController: SearchViewController) {
        floatingPanel.delegate = self
        floatingPanel.surfaceView.backgroundColor = .clear
        floatingPanel.surfaceView.shadowHidden = false
        floatingPanel.set(contentViewController: searchViewController)
        floatingPanel.track(scrollView: searchViewController.tableView)
        searchViewController.didMove(toParent: floatingPanel)
        
//        view.addSubview(floatingPanel.view)
//        NSLayoutConstraint.activate([
//            floatingPanel.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            floatingPanel.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            floatingPanel.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            floatingPanel.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//            ])
//
//        addChild(floatingPanel)
//
//        floatingPanel.show(animated: true) { [weak self] in
//            floatingPanel.didMove(toParent: self)
//        }
        
        floatingPanel.addPanel(toParent: self)
    }
}

extension MapViewController: FloatingPanelControllerDelegate {
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        switch newCollection.verticalSizeClass {
        case .compact:
            floatingPanel.surfaceView.borderWidth = 1.0 / traitCollection.displayScale
            floatingPanel.surfaceView.borderColor = UIColor.black.withAlphaComponent(0.2)
            return SearchPanelLandscapeLayout()
        default:
            floatingPanel.surfaceView.borderWidth = 0.0
            floatingPanel.surfaceView.borderColor = nil
            return nil
        }
    }
    
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        let y = vc.surfaceView.frame.origin.y
        let tipY = vc.originYOfSurface(for: .tip)
        if y > tipY - 44.0 {
            let progress = max(0.0, min((tipY  - y) / 44.0, 1.0))
            self.searchViewController.tableView.alpha = progress
        }
    }
    
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        if vc.position == .full {
            searchViewController.searchBar.showsCancelButton = false
            searchViewController.searchBar.resignFirstResponder()
        }
    }
    
    func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
        if targetPosition != .full {
            searchViewController.hideHeader()
        }
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .allowUserInteraction,
                       animations: {
                        if targetPosition == .tip {
                            self.searchViewController.tableView.alpha = 0.0
                        } else {
                            self.searchViewController.tableView.alpha = 1.0
                        }
        }, completion: nil)
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton  = false
        searchViewController.hideHeader()
        floatingPanel.move(to: .half, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchViewController.showHeader()
        searchViewController.tableView.alpha = 1.0
        floatingPanel.move(to: .full, animated: true)
    }
}
