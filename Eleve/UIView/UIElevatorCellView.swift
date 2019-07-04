//
//  UIElevatorCellView.swift
//  Eleve
//
//  Created by Marek Pridal on 04/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import UIKit

final class UIElevatorCellView: UIView {
    
    let coloredView = UIView()
    let icon = UIImageView()
    let stackView = UIStackView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    deinit {
        print("Deinit of \(self)")
    }
    
    func setup(elevator: ElevatorModel) {
        coloredView.backgroundColor = UIColor(named: "Orange") // TODO
//        icon.image = TODO
        titleLabel.text = elevator.name
        titleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 16, weight: .medium))
        subtitleLabel.text = elevator.type
        subtitleLabel.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 14, weight: .medium))
    }
    
    private func commonInit() {
        coloredView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(coloredView)
        NSLayoutConstraint.activate([
            coloredView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            coloredView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coloredView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            coloredView.heightAnchor.constraint(equalToConstant: 40),
            coloredView.widthAnchor.constraint(equalToConstant: 40)
        ])
        coloredView.layer.cornerRadius = 6
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        coloredView.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: coloredView.leadingAnchor, constant: 7),
            icon.trailingAnchor.constraint(equalTo: coloredView.trailingAnchor, constant: 7),
            icon.topAnchor.constraint(equalTo: coloredView.topAnchor, constant: 7),
            icon.bottomAnchor.constraint(equalTo: coloredView.bottomAnchor, constant: 7)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: coloredView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: coloredView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: coloredView.bottomAnchor)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
}
