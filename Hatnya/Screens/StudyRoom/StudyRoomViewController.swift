//
//  StudyRoomViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class StudyRoomViewController: UIViewController {

    // MARK: - property

    private let navigationBarRightItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "ellipsis")
        return item
    }()
    private let everyTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "모두의 숙제 현황"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    private let deadLineLabel: UILabel = {
        let label = UILabel()
        label.text = "2022. 07. 14(목) 까지"
        label.textColor = .grey001
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let dDayLabel: UILabel = {
        let label = UILabel()
        label.text = "D-5"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    private let chartView = StudyChartView()
    private lazy var codeCopyButton: UIButton = {
        let button = UIButton(type: .system)
        let action = UIAction { _ in
            UIPasteboard.general.string = "초대코드"
        }
        button.setTitle("초대 코드 복사", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }

    private func configUI() {
        view.backgroundColor = .white
        setupNavigationBar()
    }

    private func render() {
        view.addSubview(everyTaskLabel)
        everyTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            everyTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
            everyTaskLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)]
        )

        view.addSubview(deadLineLabel)
        deadLineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadLineLabel.topAnchor.constraint(equalTo: everyTaskLabel.bottomAnchor, constant: 4),
            deadLineLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)]
        )

        view.addSubview(dDayLabel)
        dDayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dDayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            dDayLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)]
        )

        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: deadLineLabel.bottomAnchor, constant: 30),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            chartView.heightAnchor.constraint(equalToConstant: 237)]
        )
        
        view.addSubview(codeCopyButton)
        codeCopyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            codeCopyButton.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 21),
            codeCopyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)]
        )
    }

    // MARK: - func

    private func setupNavigationBar() {
        title = "Swift Study"
        navigationItem.rightBarButtonItem = navigationBarRightItem
    }
}
