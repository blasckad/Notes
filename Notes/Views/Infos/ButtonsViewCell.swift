//
//  ButtonsViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class ButtonsViewCell: UITableViewCell {
    
    public var DeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Delete", comment: ""), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    public var UpdateButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Edit", comment: ""), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
        
    
    public static let reuseIdentifier = "ButtonsViewCell"
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    public override func layoutSubviews() {
        setupLayout()
    }
    
    private func setupLayout() {
        isAccessibilityElement = true
        
        
        addSubview(DeleteButton)
        addSubview(UpdateButton)
        
        DeleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DeleteButton.topAnchor.constraint(equalTo: topAnchor),
            DeleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            DeleteButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        UpdateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            UpdateButton.topAnchor.constraint(equalTo: topAnchor),
            UpdateButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            UpdateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
    }
}

