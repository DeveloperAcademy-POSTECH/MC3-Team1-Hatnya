//
//  HomeworkListCell.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import SwiftUI
import UIKit

final class HomeworkListCell: UICollectionViewCell {
    
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
    
    weak var checkDelegate: CheckDelegate?
    private var indexPath: IndexPath!
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

// MARK: - UI method

extension HomeworkListCell {
    
    @objc
    func checkButtonTouched() {
        checkDelegate?.checkDelegateButton(with: indexPath)
    }
    
    private func configureSubviews() {
        let margin: CGFloat = 20

        [checkButton, tagView, textLabel].forEach { component in
            addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tagView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            tagView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tagView.widthAnchor.constraint(equalToConstant: tagSize),
            tagView.heightAnchor.constraint(equalToConstant: tagSize)
        ])
        
        NSLayoutConstraint.activate([
            checkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            checkButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(greaterThanOrEqualToConstant: margin)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: margin),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -margin),
            textLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: margin)
        ])
        
    }

    func configureUI(with homework: Homework, index: IndexPath) {
        let checkedImage = UIImage(systemName: "checkmark.square.fill")
        let emptyImage = UIImage(systemName: "square")
        
        if homework.isCompleted {
            checkButton.setImage(checkedImage, for: .normal)
            textLabel.textColor = .gray
        } else {
            checkButton.setImage(emptyImage, for: .normal)
            textLabel.textColor = .label
        }
        textLabel.text = homework.name
        textLabel.strikeThrough(homework.isCompleted)
        tagView.backgroundColor = TagColor.order(index: index.row)
        
        indexPath = index
    }
    
}

struct HomeworkListCellPreview: PreviewProvider {
    
    static var previews: some View {
        HomeworkListCell().toPreview()
    }

}

protocol CheckDelegate: AnyObject {
    func checkDelegateButton(with indexPath: IndexPath)
}
