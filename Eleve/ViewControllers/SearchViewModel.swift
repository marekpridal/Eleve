//
//  SearchViewModel.swift
//  Eleve
//
//  Created by Marek Pridal on 02/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
import RxCocoa
import RxDataSources
import RxSwift

protocol SearchViewModelDelegate: class {
    func didSelect(elevator: ElevatorModel)
}

final class SearchViewModel {
    private let disposeBag = DisposeBag()
    
    weak var delegate: SearchViewModelDelegate?
    
    let sectionModel = BehaviorRelay<[SectionModel<String, ElevatorModel>]>(value: [])
    let searchText = BehaviorRelay<String?>(value: nil)
    let dataSource = BehaviorRelay<[ElevatorModel]>(value: [
        ElevatorModel(name: "Dejvická", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35),
        ElevatorModel(name: "Hradčanská", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35),
        ElevatorModel(name: "Malostranská", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35),
        ElevatorModel(name: "Staroměstská", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35),
        ElevatorModel(name: "Můstek", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35),
        ElevatorModel(name: "Muzeum", status: "V provozu", lastUpdate: Date(), type: "Výtah", duration: 35)
    ])
    
    init(delegate: SearchViewModelDelegate?) {
        self.delegate = delegate
        setupBinding()
    }
    
    private func setupBinding() {
        Observable.combineLatest(dataSource.asObservable(), searchText.asObservable())
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .map { (arg) -> [ElevatorModel] in
                let (dataSource, searchText) = arg
                
                return dataSource.filter { (element) -> Bool in
                    guard let searchText = searchText, !searchText.isEmpty else { return true }
                    return element
                        .name
                        .lowercased()
                        .folding(options: .diacriticInsensitive, locale: .current)
                        .contains(searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current))
                }
        }
        .map {
            [SectionModel<String, ElevatorModel>(model: "", items: $0)]
        }
        .bind(to: sectionModel)
        .disposed(by: disposeBag)
    }
}
