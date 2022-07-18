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
        return label
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }

    private func configUI() {
        view.backgroundColor = .white
        title = "Swift Study"
        navigationItem.rightBarButtonItem = navigationBarRightItem
    }

    private func render() {
        view.addSubview(everyTaskLabel)
        everyTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            everyTaskLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
            everyTaskLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            ])
    }
}
