//
//  StudyChartCollectionViewCell.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/26.
//

import UIKit

final class StudyChartCollectionViewCell: UICollectionViewCell {
    var homeworkCount = Member.testMemberList[0].homeworks.count
    // MARK: - property

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        return label
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
        self.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userNameLabel.widthAnchor.constraint(equalToConstant: 60),
            userNameLabel.heightAnchor.constraint(equalToConstant: 32)]
        )

        self.addSubview(chartStackView)
        chartStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartStackView.topAnchor.constraint(equalTo: self.topAnchor),
            chartStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            chartStackView.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 5),
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
