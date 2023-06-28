//
//  DateFieldViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit



class DateFieldViewCell: UITableViewCell {
    
    public var DueDate: UIDatePicker = {
        let date = UIDatePicker()
        date.preferredDatePickerStyle = .inline
        date.datePickerMode = .dateAndTime
        return date
    }()
    
    public static let reuseIdentifier = "DateFieldViewCell"
    
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
            DueDate.topAnchor.constraint(equalTo: topAnchor),
            DueDate.leadingAnchor.constraint(equalTo: leadingAnchor),
            DueDate.trailingAnchor.constraint(equalTo: trailingAnchor),
            DueDate.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    public func update(_ date: Date?) {
        DueDate.date = date ?? Date()
    }
    
    public func getInfo() -> UIDatePicker {
        return DueDate
    }
    
}
