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

#if canImport(SwiftUI)
import SwiftUI
#endif

final class MapViewController: UIViewController {
    
    private let floatingPanel = FloatingPanelController()
    private let mapView = MKMapView()
    private let searchViewController = SearchViewController()
    private var detailPanel: FloatingPanelController?
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(mapView: mapView)
        setup(searchViewController: searchViewController)
        setup(floatingPanel: floatingPanel, searchViewController: searchViewController)
        
        getLocation()
    }
    
    private func setup(mapView: MKMapView) {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        mapView.showsBuildings = true
        mapView.delegate = self
        
        #if DEBUG
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 50.100474, longitude: 14.393111)
        mapView.addAnnotation(annotation)
        #endif
    }
    
    private func setup(searchViewController: SearchViewController) {
        searchViewController.searchBar.delegate = self
    }
    
    private func setup(floatingPanel: FloatingPanelController, searchViewController: SearchViewController) {
        floatingPanel.delegate = self
        floatingPanel.surfaceView.backgroundColor = .clear
        floatingPanel.surfaceView.shadowHidden = false
        floatingPanel.surfaceView.cornerRadius = 6.0
        floatingPanel.set(contentViewController: searchViewController)
        floatingPanel.track(scrollView: searchViewController.tableView)
        
        floatingPanel.addPanel(toParent: self)
        floatingPanel.move(to: .tip, animated: true)
    }
    
    private func center(_ coordinates: CLLocationCoordinate2D, mapView: MKMapView) {
        mapView.setRegion(MKCoordinateRegion(center: coordinates, latitudinalMeters: CLLocationDistance(integerLiteral: 1000), longitudinalMeters: CLLocationDistance(integerLiteral: 1000)), animated: true)
    }
    
    private func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print(#function, "No access")
                
            case .authorizedAlways, .authorizedWhenInUse:
                print(#function, "Access")
                locationAccessAllowed()
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    private func locationAccessAllowed() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
        locationManager.allowsBackgroundLocationUpdates = false
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

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = manager.location?.coordinate {
            center(coordinates, mapView: mapView)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        showDetail()
    }
    
    private func showDetail() {
        self.detailPanel?.removePanelFromParent(animated: true)
        
        var detailViewController: UIViewController = ElevatorDetailViewController()
        
        if #available(iOS 13, *) {
            detailViewController = UIHostingController(rootView: ElevatorDetailView(model: ElevatorDetailViewModel(elevator: ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35_000), delegate: nil)))
        }
        
        self.detailPanel = FloatingPanelController()
        self.detailPanel?.delegate = self
        detailPanel?.surfaceView.shadowHidden = false
        detailPanel?.surfaceView.cornerRadius = 6.0
        
        detailPanel?.set(contentViewController: detailViewController)
        detailPanel?.addPanel(toParent: self, animated: true)
        
        floatingPanel.move(to: .tip, animated: false)
    }
}
