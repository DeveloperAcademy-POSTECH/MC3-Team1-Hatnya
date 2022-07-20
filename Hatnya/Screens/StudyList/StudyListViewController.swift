//
//  StudyListViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class StudyListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension StudyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudyGroup.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studyListCell", for: indexPath)
        
        cell.textLabel?.text = StudyGroup.sampleData[indexPath.row].studyName
        cell.detailTextLabel?.text = StudyGroup.sampleData[indexPath.row].description
        
        return cell
    }
}
