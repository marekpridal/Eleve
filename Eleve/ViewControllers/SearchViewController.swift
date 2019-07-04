//
//  SearchViewController.swift
//  Eleve
//
//  Created by Marek Pridal on 01/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import FloatingPanel
import UIKit
import RxCocoa
import RxDataSources
import RxSwift

final class SearchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    let viewModel: SearchViewModel
    
    let searchBar = UISearchBar()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setup(searchBar: searchBar)
        setup(tableView: tableView, searchBar: searchBar)
        setupDateSources()
        setupBinding()
    }
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideHeader() {
        
    }
    
    func showHeader() {
        
    }
    
    private func setupBinding() {
        searchBar.rx.text.bind(to: viewModel.searchText).disposed(by: disposeBag)
        searchBar.rx.cancelButtonClicked.map { _ -> String? in return nil }.bind(to: viewModel.searchText).disposed(by: disposeBag)
    }
    
    private func setupDateSources() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(configureCell: { (model, tableView, indexPath, value) -> UIElevatorTableViewCell in
            let cell = UIElevatorTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "UIElevatorTableViewCell")
            cell.setup(elevator: ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35))
            return cell
        })
        
        viewModel.sectionModel.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    private func setup(searchBar: UISearchBar) {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 6),
            searchBar.heightAnchor.constraint(equalToConstant: 60)
            ])
        searchBar.searchBarStyle = .minimal
    }
    
    private func setup(tableView: UITableView, searchBar: UISearchBar) {
        tableView.register(UIElevatorTableViewCell.self, forCellReuseIdentifier: "UIElevatorTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
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
