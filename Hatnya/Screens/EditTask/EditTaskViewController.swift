//
//  EditTaskViewController.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/21.
//

import SwiftUI
import UIKit

class EditTaskViewController: UIViewController {
    
    private var taskDataSource: UITableViewDiffableDataSource<EditTaskSection, Homework>!
    private var snapshot = NSDiffableDataSourceSnapshot<EditTaskSection, Homework>()
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureDatasource()
        tableView.isEditing = true
        applySnapshot()
    }
    
}

private enum EditTaskSection {
    case main
}

private class EditTaskDatasource: UITableViewDiffableDataSource<EditTaskSection, Homework> {
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let sourceIdentifier = itemIdentifier(for: sourceIndexPath) else { return }
        guard let destinationIdentifier = itemIdentifier(for: destinationIndexPath) else { return }
        guard sourceIndexPath != destinationIndexPath else { return }
        
        var snapshot = snapshot()
        
        if let sourceIndex = snapshot.indexOfItem(sourceIdentifier),
           let destinationIndex = snapshot.indexOfItem(destinationIdentifier) {
            snapshot.deleteItems([sourceIdentifier])
            let isAfter = destinationIndex > sourceIndex
            
            if isAfter {
                snapshot.insertItems([sourceIdentifier], afterItem: destinationIdentifier)
            } else {
                snapshot.insertItems([sourceIdentifier], beforeItem: destinationIdentifier)
            }
        }
        
        apply(snapshot, animatingDifferences: true)
    }
    
}

extension EditTaskViewController {

    private func configureLayout() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDatasource() {
        taskDataSource = EditTaskDatasource(tableView: tableView, cellProvider: { tableView, indexPath, task in
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = task.name
            cell.contentConfiguration = content
            return cell
        })
    }
    
    private func applySnapshot() {
        snapshot.appendSections([.main])
        snapshot.appendItems(HomeworkMockData.list, toSection: .main)
        taskDataSource.apply(snapshot)
    }
    
}

struct EditTaskPreview: PreviewProvider {
    
    static var previews: some View {
        EditTaskViewController().toPreview()
    }

}
