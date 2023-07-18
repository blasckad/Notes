//
//  ShortMemoViewCell.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 29.06.2023.
//

import UIKit

public class ShortMemoViewCell: UICollectionViewCell {
    
    private var Label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        label.textAlignment = .center
        return label
    }()
    
    private var TitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        label.font = label.font.withSize(12)
        label.text = NSLocalizedString("TITEL", comment: "")
        return label
    }()
    
    private var DueDate: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        label.textAlignment = .center
        return label
    }()
    
    private var DateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.isAccessibilityElement = false
        label.font = label.font.withSize(12)
        label.text = NSLocalizedString("DATE AND TIME OF THE EVENT", comment: "")
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
        areaEffect.layer.cornerRadius = 10
        
        addSubview(areaEffect)
        areaEffect.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            areaEffect.leadingAnchor.constraint(equalTo: leadingAnchor),
            areaEffect.topAnchor.constraint(equalTo: topAnchor),
            areaEffect.bottomAnchor.constraint(equalTo: bottomAnchor),
            areaEffect.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        areaEffect.contentView.addSubview(TitleLabel)
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            TitleLabel.topAnchor.constraint(equalTo: areaEffect.topAnchor, constant: 15),
            TitleLabel.leadingAnchor.constraint(equalTo: areaEffect.leadingAnchor, constant: 15),
        ])
        
        areaEffect.contentView.addSubview(Label)
        Label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            Label.bottomAnchor.constraint(equalTo: areaEffect.bottomAnchor, constant: -15),
            Label.leadingAnchor.constraint(equalTo: areaEffect.leadingAnchor, constant: 15),
        ])
        
        areaEffect.contentView.addSubview(DateLabel)
        DateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            DateLabel.topAnchor.constraint(equalTo: areaEffect.topAnchor, constant: 15),
            DateLabel.trailingAnchor.constraint(equalTo: areaEffect.trailingAnchor, constant: -15),
        ])
        
        areaEffect.contentView.addSubview(DueDate)
        DueDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            DueDate.bottomAnchor.constraint(equalTo: areaEffect.bottomAnchor, constant: -15),
            DueDate.trailingAnchor.constraint(equalTo: areaEffect.trailingAnchor, constant: -15)
        ])
    }
    
    public static let reuseIdentifier = "ShortMemoViewCell"

    public func update(_ memoInfo: MemoItemModel) {
        if memoInfo.label == "" {
            Label.text = NSLocalizedString("Empty", comment: "")
        } else {
            Label.text = memoInfo.label
        }
        
        guard let date = memoInfo.dueDate else { return }
        
        let dateFormatter = DateFormatter()
        
        
        
        dateFormatter.dateFormat = "LLLL d, h:mm a"
        let dateString = dateFormatter.string(from: date)
        
        DueDate.text = dateString
    }
}
