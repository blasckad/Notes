//
//  LabelInfoViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class LabelInfoViewCell: UITableViewCell {
    
    public var Label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        return label
    }()        
    
    public static let reuseIdentifier = "LabelInfoViewCell"
    
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
        if label == "" {
            Label.text = NSLocalizedString("Empty", comment: "")
        }
        else {
            Label.text = label
        }
    }    
    
}
