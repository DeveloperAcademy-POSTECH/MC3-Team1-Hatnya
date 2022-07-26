//
//  DayButtonView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/21.
//

import UIKit

final class DayButtonView: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configUI() {
        backgroundColor = .systemBackground
        setTitleColor(UIColor.systemBlue, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        layer.cornerRadius = 16
        addTarget(self, action: #selector(dayButtonTouch), for: .touchUpInside)
        frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 32, height: 32))
    }
    
    private func render() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 32).isActive = true
        heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc
    private func dayButtonTouch() {
        if isSelected {
            backgroundColor = .systemBackground
            setTitleColor(UIColor.systemBlue, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 20)
        } else {
            backgroundColor = .systemBlue
            setTitleColor(UIColor.white, for: .normal)
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        isSelected.toggle()
        print(title(for: .selected) ?? "")
    }
    
    func setName(title: String) {
        self.setTitle(title, for: .normal)
    }
    
}
