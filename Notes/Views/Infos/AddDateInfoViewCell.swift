//
//  AddDateInfoViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class AddDateInfoViewCell: UITableViewCell {
    
    public var AddDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        return label
    }()
        
    
    public static let reuseIdentifier = "AddDateInfoViewCell"
    
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
        
        addSubview(AddDate)
        
        AddDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            AddDate.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            AddDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            AddDate.trailingAnchor.constraint(equalTo: trailingAnchor),
            AddDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        
    }
    
    public func update(_ date: Date?) {
        
        guard let addDate = date else { return }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "LLLL d, yyyy, h:mm a"
        let dateString = dateFormatter.string(from: addDate)
        
        AddDate.text = dateString
        
        
    }
    
}

