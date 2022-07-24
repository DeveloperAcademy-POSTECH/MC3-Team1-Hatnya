//
//  StudyListViewController.swift
//  Hatnya
//
//  Created by 김원희 on 2022/07/18.
//

import UIKit

class StudyListViewController: UIViewController {

    @IBAction private func showASBtn(_ sender: Any) {
        showActionSheet()
    }
    
    private let emptyStudyLabel: UILabel = {
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
        
        let first = UIAlertAction(title: "스터디 참여하기", style: .default) { _ in
            print("스터디 코드 입력 view로 연결")
        }
        let second = UIAlertAction(title: "스터디 생성하기", style: .default) { _ in
            print("스터디 생성 view로 연결")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        actionSheet.addAction(first)
        actionSheet.addAction(second)
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
        
        let dataSource = StudyInfo(name: StudyGroup.sampleData[indexPath.row].studyName,
                                   desc: StudyGroup.sampleData[indexPath.row].description)
        cell.configure(with: dataSource)
        
        return cell
    }
}
