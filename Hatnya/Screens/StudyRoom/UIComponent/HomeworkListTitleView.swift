//
//  HomeworkListTitleView.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import SwiftUI
import UIKit

final class HomeworkListTitleView: UICollectionReusableView {
    
    weak var delegate: EditDelegate?
    
    private lazy var titleLabel: UILabel = {
        $0.text = "숙제 목록"
        $0.textColor = .gray
        return $0
    }(UILabel())
    
    private lazy var plusButton: UIButton = {
        let plusImage = UIImage(systemName: "plus")
        $0.setImage(plusImage, for: .normal)
        $0.addTarget(self, action: #selector(plusButtonTouched), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
        backgroundColor = .systemBackground
    }
    
}

extension HomeworkListTitleView {
    
    private func configureSubviews() {
        let margin: CGFloat = 15
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: margin),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: margin)
        ])
        
        addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            plusButton.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            plusButton.widthAnchor.constraint(greaterThanOrEqualToConstant: margin),
            plusButton.heightAnchor.constraint(greaterThanOrEqualToConstant: margin)
        ])
    }
    
    @objc
    func plusButtonTouched() {
        delegate?.editButtonTapped()
        
    }
    
}

struct HomeworkListTitlePreview: PreviewProvider {
    
    static var previews: some View {
        HomeworkListTitleView().toPreview()
    }

}

protocol EditDelegate: AnyObject {
    func editButtonTapped()
}
