//
//  DueDateInfoViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

class DueDateInfoViewCell: UITableViewCell {
    
    public var DueDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        return label
    }()
    
    
    public static let reuseIdentifier = "DueDateInfoViewCell"
    
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
        
        addSubview(DueDate)
        
        DueDate.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            DueDate.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            DueDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            DueDate.trailingAnchor.constraint(equalTo: trailingAnchor),
            DueDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
    
    public func update(_ date: Date?) {
        
        guard let dueDate = date else { return }
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "LLLL d, yyyy, h:mm a"
        let dateString = dateFormatter.string(from: dueDate)
        
        DueDate.text = dateString
    }
    
}

