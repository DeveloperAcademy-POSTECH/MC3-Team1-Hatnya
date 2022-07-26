//
//  StudyChartCollectionViewCell.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/26.
//

import UIKit

final class StudyChartCollectionViewCell: UICollectionViewCell {
    
    private let chartView = StudyChartView()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }
    
    private func render() {
        addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: self.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
