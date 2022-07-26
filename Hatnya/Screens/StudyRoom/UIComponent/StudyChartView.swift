//
//  StudyChartView.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/19.
//

import UIKit

class StudyChartView: UIView {
    var homeworkCount = 8

    // MARK: - property

    private let studianList: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.grey001.cgColor
        return view
    }()
    private lazy var chartStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 5
        return stackView
    }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
        configUI()
    }

    private func render() {
        addSubview(chartStackView)
        chartStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            chartStackView.topAnchor.constraint(equalTo: self.topAnchor),
            chartStackView.widthAnchor.constraint(equalToConstant: 266),
            chartStackView.heightAnchor.constraint(equalToConstant: 32)]
        )
    }

    private func configUI() {
        setupChartStackView()
    }

    // MARK: - func

    private func setupChartStackView() {
        for index in 0..<homeworkCount {
            let testView = UIView()
            testView.backgroundColor = UIColor.colorPalette[index]
            testView.layer.cornerRadius = 5
            chartStackView.addArrangedSubview(testView)
        }
    }
}
