//
//  StudyListViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class StudyListViewController: UIViewController {

    @IBAction private func showASBtn(_ sender: Any) {
        showActionSheet()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let first = UIAlertAction(title: "스터디 참여하기", style: .default) { _ in
            print("첫번째")
        }
        let second = UIAlertAction(title: "스터디 생성하기", style: .default) { _ in
            print("두번째")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소")
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
        
        cell.studyName.text = StudyGroup.sampleData[indexPath.row].studyName
        cell.studyDesc.text = StudyGroup.sampleData[indexPath.row].description
        cell.layer.cornerRadius = 13
        
        return cell
    }
}
