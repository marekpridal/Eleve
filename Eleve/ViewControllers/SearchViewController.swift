//
//  SearchViewController.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import FloatingPanel
import UIKit

final class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(searchBar: searchBar)
        setup(tableView: tableView, searchBar: searchBar)
    }
    
    func hideHeader() {
        
    }
    
    func showHeader() {
        
    }
    
    private func setup(searchBar: UISearchBar) {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    private func setup(tableView: UITableView, searchBar: UISearchBar) {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchBar.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
    }
}

final class SearchPanelLandscapeLayout: FloatingPanelLayout {
    var initialPosition: FloatingPanelPosition {
        return .tip
    }
    
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.full, .tip]
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 16.0
        case .tip: return 69.0
        default: return nil
        }
    }
    
    func prepareLayout(surfaceView: UIView, in view: UIView) -> [NSLayoutConstraint] {
        return [
            surfaceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8.0),
            surfaceView.widthAnchor.constraint(equalToConstant: 291),
        ]
    }
    
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }
}
