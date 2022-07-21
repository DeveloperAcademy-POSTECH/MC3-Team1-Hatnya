//
//  StudyChartView.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/19.
//

import SwiftUI
import UIKit

class StudyChartView: UIView {
    
   // MARK: - property
    
    private let studianList: UIView = {
        let view = UIView()
//        view.layer.backgroundColor = UIColor.grey001.cgColor
        return view
    }()
    
    private let chartPerHomework: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.black.cgColor
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func render() {
        addSubview(studianList)
        studianList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studianList.widthAnchor.constraint(equalTo: self.widthAnchor),
            studianList.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        addSubview(chartPerHomework)
        chartPerHomework.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartPerHomework.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                    constant: 20),
            chartPerHomework.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            chartPerHomework.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
}

struct StudyChartViewPreview: PreviewProvider {
    static var previews: some View {
        StudyChartView().toPreview()
    }
}
