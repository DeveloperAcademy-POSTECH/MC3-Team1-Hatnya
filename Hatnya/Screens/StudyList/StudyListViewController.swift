//
//  StudyListViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

final class StudyListViewController: UIViewController {
    
    @IBAction private func showActionSheetButton(_ sender: Any) {
        showActionSheet()
    }
    
    private lazy var emptyStudyLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 그룹이 없습니다."
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
    }
    
    private func render() {
        if StudyGroup.sampleData.isEmpty {
            view.addSubview(emptyStudyLabel)
            let safeArea = view.safeAreaLayoutGuide
            
            emptyStudyLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyStudyLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            emptyStudyLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        }
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let enterStudyButton = UIAlertAction(title: "스터디 참여하기", style: .default) { [weak self] _ in
            let joinStudystoryboard = UIStoryboard(name: "JoinStudyView", bundle: nil)
            let joinStudyViewController = joinStudystoryboard.instantiateViewController(identifier: "JoinStudyView")
            let navigationController = UINavigationController(rootViewController: joinStudyViewController)
            navigationController.navigationBar.topItem?.title = ""
            self?.present(navigationController, animated: true, completion: nil)
        }
        let createStudyButton = UIAlertAction(title: "스터디 생성하기", style: .default) { [weak self] _ in
            let createViewVontroller = CreateStudyViewController()
            let navigationController = UINavigationController(rootViewController: createViewVontroller)
            navigationController.navigationBar.topItem?.title = ""
            self?.present(navigationController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        actionSheet.addAction(enterStudyButton)
        actionSheet.addAction(createStudyButton)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension StudyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudyGroup.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudyListTableViewCell.identifier,
                                                       for: indexPath) as? StudyListTableViewCell else {
            return UITableViewCell()
        }
        
        let dataSource = StudyGroup(members: StudyGroup.sampleData[indexPath.row].members,
                                    name: StudyGroup.sampleData[indexPath.row].name,
                                    code: StudyGroup.sampleData[indexPath.row].code,
                                    description: StudyGroup.sampleData[indexPath.row].description,
                                    cycle: StudyGroup.sampleData[indexPath.row].cycle,
                                    createdAt: StudyGroup.sampleData[indexPath.row].createdAt)
        cell.configure(with: dataSource)
        
        return cell
    }
}
