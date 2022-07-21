//
//  DayButtonView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/21.
//

import UIKit
import SwiftUI

class DayButtonView: UIButton {
    var  isClicked = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.backgroundColor = .systemBackground
        self.setTitleColor(UIColor.systemBlue, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.layer.cornerRadius = 16
        self.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
        self.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 32, height: 32))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc func buttonTouch() {
        if isClicked {
            self.backgroundColor = .systemBackground
            self.setTitleColor(UIColor.systemBlue, for: .normal)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        } else {
            self.backgroundColor = .systemBlue
            self.setTitleColor(UIColor.white, for: .normal)
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        isClicked.toggle()
    }
    
    func setName(title: String) {
        self.setTitle(title, for: .normal)
    }
}
