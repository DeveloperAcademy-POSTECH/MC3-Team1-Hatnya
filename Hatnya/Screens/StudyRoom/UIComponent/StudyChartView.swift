//
//  StudyChartView.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/19.
//

import UIKit

final class StudyChartView: UIView {
    var homeworkCount = Member.testMemberList[0].homeworks.count

    // MARK: - property

    private let studianList: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.grey001.cgColor
        return view
    }()
    private let chartStackView: UIStackView = {
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
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }

    private func render() {
        let width = UIScreen.main.bounds.width * 0.65
        addSubview(chartStackView)
        chartStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            chartStackView.topAnchor.constraint(equalTo: self.topAnchor),
            chartStackView.widthAnchor.constraint(equalToConstant: width),
            chartStackView.heightAnchor.constraint(equalToConstant: 32)]
        )
    }

    // MARK: - func

    func setupChartStackView(_ list: [Bool]) {
        if chartStackView.arrangedSubviews.count < homeworkCount {
            for index in 0..<homeworkCount {
                let testView = UIView()
                if list[index] {
                    testView.backgroundColor = UIColor.colorPalette[index]
                } else {
                    testView.backgroundColor = .grey002
                }
                testView.layer.cornerRadius = 5
                chartStackView.addArrangedSubview(testView)
            }
        }
    }
}
