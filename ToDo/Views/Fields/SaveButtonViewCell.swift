//
//  SaveButtonViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class SaveButtonViewCell: UITableViewCell {
    
   
    public var SaveButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    public static let reuseIdentifier = "SaveButtonViewCell"
    
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
        
        addSubview(SaveButton)
        
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            SaveButton.topAnchor.constraint(equalTo: topAnchor),
            SaveButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            SaveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            SaveButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    
}
