//
//  AddMemoButtonViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 12.07.2023.
//

import UIKit

public class AddMemoButtonViewCell: UICollectionViewCell {
    
    public static let reuseIdentifier = "AddMemoButtonViewCell"
    
    private var AddLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        label.textAlignment = .center
        return label
    }()
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    public override func layoutSubviews() {
        setupLayout()
    }
    
    private func setupLayout() {
        isAccessibilityElement = true
            
        let areaEffect = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        areaEffect.clipsToBounds = true
        areaEffect.layer.cornerRadius = 16
        
        addSubview(areaEffect)
        areaEffect.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            areaEffect.leadingAnchor.constraint(equalTo: leadingAnchor),
            areaEffect.topAnchor.constraint(equalTo: topAnchor),
            areaEffect.bottomAnchor.constraint(equalTo: bottomAnchor),
            areaEffect.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        areaEffect.contentView.addSubview(AddLabel)
        
        AddLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            AddLabel.topAnchor.constraint(equalTo: areaEffect.topAnchor),
            AddLabel.bottomAnchor.constraint(equalTo: areaEffect.bottomAnchor),
            AddLabel.leadingAnchor.constraint(equalTo: areaEffect.leadingAnchor),
            AddLabel.trailingAnchor.constraint(equalTo: areaEffect.trailingAnchor)
        ])
        
        AddLabel.text = NSLocalizedString("Add Memo", comment: "")
    }
    
    
}

