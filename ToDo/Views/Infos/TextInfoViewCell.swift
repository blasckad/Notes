//
//  TextInfoViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class TextInfoViewCell: UITableViewCell {
        
    public var Text: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        label.numberOfLines = 100
        return label
    }()
    
    public static let reuseIdentifier = "TextInfoViewCell"
    
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
        
        addSubview(Text)
                
        Text.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Text.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            Text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            Text.trailingAnchor.constraint(equalTo: trailingAnchor),
            Text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    public func update(_ label: String?) {
        if label == "" {
            Text.text = NSLocalizedString("Empty", comment: "")
        }
        else {
            Text.text = label
        }
    }
    
}
