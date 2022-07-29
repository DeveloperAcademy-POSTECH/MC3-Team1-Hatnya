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
        buttonColorToWhite()
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        layer.cornerRadius = 16
        addTarget(self, action: #selector(touchDayButton), for: .touchUpInside)
        frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 32, height: 32))
    }
    
    private func render() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 32).isActive = true
        heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc
    private func touchDayButton() {
        if isSelected {
            buttonColorToWhite()
        } else {
            buttonColorToBlue()
        }
        isSelected.toggle()
    }
    
    private func buttonColorToWhite() {
        backgroundColor = .systemBackground
        setTitleColor(UIColor.systemBlue, for: .normal)
    }
    
    func buttonColorToBlue() {
        backgroundColor = .systemBlue
        setTitleColor(UIColor.white, for: .normal)
    }
    
    func setName(title: String) {
        self.setTitle(title, for: .normal)
    }
    
}
