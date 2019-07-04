//
//  UIElevatorTableViewCell.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import UIKit

final class UIElevatorTableViewCell: UITableViewCell {
    
    private let elevatorCellView = UIElevatorCellView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func setup(elevator: ElevatorModel)  {
        elevatorCellView.setup(elevator: elevator)
    }
    
    private func commonInit() {
        elevatorCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(elevatorCellView)
        NSLayoutConstraint.activate([
            elevatorCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            elevatorCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            elevatorCellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            elevatorCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
