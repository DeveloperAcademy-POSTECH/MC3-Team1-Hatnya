//
//  EditTaskViewController.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/21.
//

import Combine
import FirebaseCore
import FirebaseFirestore
import SwiftUI
import UIKit

final class EditTaskViewController: UIViewController {
    
    private var networkManager = NetworkManager()
    private typealias Snapshot = NSDiffableDataSourceSnapshot<EditTaskSection, Homework>
    private var taskDataSource: UITableViewDiffableDataSource<EditTaskSection, Homework>!
    private var snapshot = Snapshot()
    private var tableView: UITableView!
    private var cancelable = Set<AnyCancellable>()
    private var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavi()
        configureLayout()
        configureDatasource()
        fetch()
    }
    
}

// MARK: - Configure Navigation

extension EditTaskViewController {
    
    private func configureNavi() {
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.title = "숙제 목록"
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTouched))
        self.navigationItem.rightBarButtonItem = completeButton
    }
    
    @objc
    func completeButtonTouched() {
        snapshot = taskDataSource.snapshot()
        let updatedData = Homeworks(count: count, list: snapshot.itemIdentifiers)
        networkManager.getHomeworkPath(count: 1) { path in
            self.networkManager.post(with: updatedData, path: path)
        }
        dismiss(animated: true)
    }
    
}

// MARK: - Configure TableView

extension EditTaskViewController {

    private func configureLayout() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(EditTaskTableViewCell.self, forCellReuseIdentifier: EditTaskTableViewCell.description())
        tableView.register(EditTaskSupplementaryView.self,
                           forHeaderFooterViewReuseIdentifier: EditTaskSupplementaryView.description())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isEditing = true
        tableView.delegate = self
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
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EditTaskTableViewCell.description(),
                for: indexPath) as? EditTaskTableViewCell else { return UITableViewCell() }
            cell.setText(with: task.name)
            return cell
        })
    }
    
    private func applySnapshot(with items: [Homework]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        self.snapshot = snapshot
        taskDataSource.apply(snapshot)
    }
    
    private func fetch() {
        networkManager.getHomeworkPath(count: 1) { path in
            self.networkManager.get(for: Homeworks.self, path: path) { [weak self] homeworks in
                self?.applySnapshot(with: homeworks.list)
                self?.count = homeworks.count
            }
        }
    }
    
}

// MARK: - Edit TableView

extension EditTaskViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: EditTaskSupplementaryView.description()) as? EditTaskSupplementaryView else { return UIView() }
        
        footerView.$newTask
            .dropFirst()
            .sink { [weak self] homework in
                self?.snapshot.appendItems([homework], toSection: .main)
                self?.taskDataSource.apply(self?.snapshot ?? Snapshot(), animatingDifferences: true)
            }
            .store(in: &cancelable)
        
        return footerView
    }
    
}

private enum EditTaskSection {
    case main
}

private class EditTaskDatasource: UITableViewDiffableDataSource<EditTaskSection, Homework> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        var snapshot = snapshot()

        if editingStyle == .delete {
            if let identifierToDelete = itemIdentifier(for: indexPath) {
                snapshot.deleteItems([identifierToDelete])
            }
        }
        apply(snapshot)
    }
    
}

struct EditTaskPreview: PreviewProvider {
    
    static var previews: some View {
        EditTaskViewController().toPreview()
    }

}
