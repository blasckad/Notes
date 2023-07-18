//
//  TextFieldViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit



class TextFieldViewCell: UITableViewCell {
  
    
    public var Text: UITextView = {
        let textField = UITextView()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.placeholder = NSLocalizedString("text..", comment: "")
        return textField
    }()
    
    public static let reuseIdentifier = "TextFieldViewCell"
    
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
        Text.sizeToFit()
                      
        Text.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Text.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            Text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            Text.trailingAnchor.constraint(equalTo: trailingAnchor),
            Text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
    }
    
   
    public func update(_ text: String?) {
        if text != "" {
            Text.text = text
            Text.placeholder = ""
        }        
    }
    
    public func getInfo() -> UITextView {
        return Text
    }
    
}
