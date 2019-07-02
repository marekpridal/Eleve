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
    
}

final class SearchViewModel {
    private let disposeBag = DisposeBag()
    
    weak var delegate: SearchViewModelDelegate?
    
    let sectionModel = BehaviorRelay<[SectionModel<String, String>]>(value: [])
    let searchText = BehaviorRelay<String?>(value: nil)
    let dataSource = BehaviorRelay<[String]>(value: ["Dejvická", "Hradčanská", "Malostranská", "Staroměstská", "Můstek", "Muzeum"])
    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        Observable.combineLatest(dataSource.asObservable(), searchText.asObservable())
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .map { (arg) -> [String] in
                let (dataSource, searchText) = arg
                
                return dataSource.filter { (element) -> Bool in
                    guard let searchText = searchText, !searchText.isEmpty else { return true }
                    return element
                        .lowercased()
                        .folding(options: .diacriticInsensitive, locale: .current)
                        .contains(searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current))
                }
        }
        .map {
            [SectionModel<String, String>(model: "", items: $0)]
        }
        .bind(to: sectionModel)
        .disposed(by: disposeBag)
    }
}
