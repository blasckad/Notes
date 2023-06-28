//
//  LabelFieldViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class LabelFieldViewCell: UITableViewCell {
        
    public var Label: UITextField = {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("label..", comment: "")
        return textField
    }()
    
    public static let reuseIdentifier = "LabelFieldViewCell"
    
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
        
        addSubview(Label)
        
        Label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            Label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            Label.trailingAnchor.constraint(equalTo: trailingAnchor),
            Label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
    public func update(_ label: String?) {
        Label.text = label
    }
    
    public func getInfo() -> UITextField {
        return Label
    }
    
    
    
}
