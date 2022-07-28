//
//  StudyChartCollectionViewCell.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/26.
//

import UIKit

final class StudyChartCollectionViewCell: UICollectionViewCell {
    
    // MARK: - property

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        return label
    }()
    lazy var chartView: StudyChartView = {
        let view = StudyChartView()
        return view
    }()

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
        self.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userNameLabel.widthAnchor.constraint(equalToConstant: 60),
            userNameLabel.heightAnchor.constraint(equalToConstant: 32)]
        )

        self.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: self.topAnchor),
            chartView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            chartView.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
        )
    }
}
