//
//  HomeworkListCell.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import SwiftUI
import UIKit

class HomeworkListCell: UICollectionViewCell {
    
    private lazy var checkButton: UIButton = {
        let emptyCheckImage = UIImage(systemName: "square")
        $0.setImage(emptyCheckImage, for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 25), forImageIn: .normal)
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(checkButtonTouched), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var textLabel: UILabel = {
        $0.text = "알고리즘 1091번"
        $0.font = .systemFont(ofSize: 19)
        return $0
    }(UILabel())
    
    private lazy var tagView: UIView = {
        $0.backgroundColor = .blue
        $0.frame.size = CGSize(width: self.tagSize, height: self.tagSize)
        $0.layer.cornerRadius = $0.frame.size.width / 2
        return $0
    }(UIView())
    
    var isComplished = false
    private let tagSize: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
    }
    
}

extension HomeworkListCell {
    
    @objc
    func checkButtonTouched() {
        let checkedImage = UIImage(systemName: "checkmark.square.fill")
        let emptyImage = UIImage(systemName: "square")
        
        if isComplished {
            checkButton.setImage(emptyImage, for: .normal)
            textLabel.textColor = .label
        } else {
            checkButton.setImage(checkedImage, for: .normal)
            textLabel.textColor = .gray
        }
        
        isComplished.toggle()
    }
    
    private func configureSubviews() {
        let margin: CGFloat = 20

        addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            checkButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(greaterThanOrEqualToConstant: margin)
        ])
        
        addSubview(tagView)
        tagView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            tagView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tagView.widthAnchor.constraint(equalToConstant: tagSize),
            tagView.heightAnchor.constraint(equalToConstant: tagSize)
        ])
        
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: margin),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: -margin),
            textLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: margin),
            textLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: margin)
        ])
        
    }
    
    func configureContent(item: Homework, index: Int) {
        textLabel.text = item.name
        tagView.backgroundColor = TagColor.order(index: index)
    }
    
}

struct HomeworkListCellPreview: PreviewProvider {
    
    static var previews: some View {
        HomeworkListCell().toPreview()
    }

}

enum TagColor: Int, CaseIterable {
    case pink
    case yellow
    case green
    case lightBlue
    case purple
    
    static func color(_ tagColor: TagColor) -> UIColor {
        switch tagColor {
        case .pink:
            return .tagPink
        case .yellow:
            return .tagYellow
        case .green:
            return .tagGreen
        case .lightBlue:
            return .tagLightBlue
        case .purple:
            return .tagPurple
        }
    }
    
    static func order(index: Int) -> UIColor {
        let colorNum = index % Self.allCases.count
        let orderColor = TagColor(rawValue: colorNum) ?? .pink
        return Self.color(orderColor)
    }

}
