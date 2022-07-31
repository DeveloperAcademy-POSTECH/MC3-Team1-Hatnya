//
//  StudyRoomViewController.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/18.
//

import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import UIKit

final class StudyRoomViewController: UIViewController {
    var deadLineString = "2022.08.01"
    var oneDayTimeInterval: Double = 86_400
    
    private enum Menu {
        case inviteTeam
        case editDate
        case editNickname(action: (() -> Void))
        case leaveStudy(action: (() -> Void))
        
        var menuTitle: String {
            switch self {
            case .inviteTeam:
                return "팀원 초대하기"
            case .editDate:
                return "기간 수정하기"
            case .editNickname:
                return "닉네임 수정하기"
            case .leaveStudy:
                return "스터디 탈퇴하기"
            }
        }
        
        var action: UIAction {
            switch self {
            case .inviteTeam:
                return UIAction(title: self.menuTitle, handler: { _ in
                    // TODO: toast 추가
                    UIPasteboard.general.string = "초대코드"
                })
            case .editDate:
                return UIAction(title: self.menuTitle, handler: { _ in
                })
            case .editNickname(let action):
                return UIAction(title: self.menuTitle, handler: { _ in
                    action()
                })
            case .leaveStudy(let action):
                return UIAction(title: self.menuTitle, attributes: .destructive, handler: { _ in
                    action()
                })
            }
        }
    }
    
    // MARK: - property

    private lazy var navigationBarRightItem: UIBarButtonItem = {
        let item = UIBarButtonItem()
        item.image = UIImage(systemName: "ellipsis")
        item.menu = setupNavigationRightButton()
        return item
    }()
    private lazy var taskBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    private lazy var everyTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "모두의 숙제 현황"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private lazy var deadLineLabel: UILabel = {
        let label = UILabel()
        label.text = "\(deadLineString)(\(setDayOfWeek(deadLineString.stringToDate))) 까지"
        label.textColor = .grey001
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private lazy var dDayLabel: UILabel = {
        let label = UILabel()
        label.text = "D-\(getDateDifference())"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 74, height: 32)
        return layout
    }()
    private lazy var chartCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            StudyChartCollectionViewCell.self,
            forCellWithReuseIdentifier: StudyChartCollectionViewCell.className)
        return collectionView
    }()

    // MARK: - HomeworkList property

    private let sectionHeaderElementKind = "section-header-element-kind"

    enum HomeworkSection {
        case main
    }

    typealias Datasource = UICollectionViewDiffableDataSource<HomeworkSection, Homework>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeworkSection, Homework>
    
    private var viewModel = HomeworkViewModel()
    private var collectionView: UICollectionView!
    private var datasource: Datasource!
    private var snapshot = Snapshot()
    private var cycle = 1
}

    // MARK: - life cycle

extension StudyRoomViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        configureHierachy()
        configureDatasource()
        applySnapShot()
        fetch()
    }

    private func configUI() {
        view.backgroundColor = .backgroundGrey
        setupNavigationBar()
    }

    private func render() {
        view.addSubview(taskBackgroundView)
        taskBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 69),
            taskBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            taskBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            taskBackgroundView.heightAnchor.constraint(equalToConstant: 360)]
        )

        taskBackgroundView.addSubview(everyTaskLabel)
        everyTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            everyTaskLabel.topAnchor.constraint(equalTo: taskBackgroundView.topAnchor, constant: 25),
            everyTaskLabel.leadingAnchor.constraint(equalTo: taskBackgroundView.leadingAnchor, constant: 21)]
        )

        taskBackgroundView.addSubview(deadLineLabel)
        deadLineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadLineLabel.topAnchor.constraint(equalTo: everyTaskLabel.bottomAnchor, constant: 4),
            deadLineLabel.leadingAnchor.constraint(equalTo: taskBackgroundView.leadingAnchor, constant: 20)]
        )

        taskBackgroundView.addSubview(dDayLabel)
        dDayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dDayLabel.topAnchor.constraint(equalTo: taskBackgroundView.topAnchor, constant: 25),
            dDayLabel.trailingAnchor.constraint(equalTo: taskBackgroundView.trailingAnchor, constant: -26)]
        )

        taskBackgroundView.addSubview(chartCollectionView)
        chartCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartCollectionView.topAnchor.constraint(equalTo: deadLineLabel.bottomAnchor, constant: 29),
            chartCollectionView.leadingAnchor.constraint(equalTo: taskBackgroundView.leadingAnchor, constant: 16),
            chartCollectionView.trailingAnchor.constraint(equalTo: taskBackgroundView.trailingAnchor, constant: -16),
            chartCollectionView.bottomAnchor.constraint(equalTo: taskBackgroundView.bottomAnchor, constant: -10)]
        )
    }

    // MARK: - func

    private func setupNavigationBar() {
        title = "Swift Study"
        navigationItem.rightBarButtonItem = navigationBarRightItem
    }

    private func getDateDifference() -> Int {
        guard let date = deadLineString.stringToDate else { return 0 }
        let distance = date.distance(to: Date())
        let resultToDouble = Double(distance) / oneDayTimeInterval
        let result = abs(Int(resultToDouble))
        return result
    }

    private func setDayOfWeek(_ day: Date?) -> String {
        guard let date = day else { return "" }
        return date.getDayOfWeek
    }
    
    private func fetch() {
        let database = Firestore.firestore()
        let path = "/StudyGroup/w2sEujplXcqubgaYYUdZ/Members/R2kwDarTzaudc5JnGpL5/Homeworks/0mo72FPYAitcvpwnKQEI"
        
        database.document(path)
            .addSnapshotListener { snapshot, error in
                guard let document = snapshot else { return }
                do {
                    let data = try document.data(as: Homeworks.self)
                    self.viewModel.update(with: data)
                    print(data)
                    
                    self.snapshot.deleteAllItems()
                    self.snapshot.appendSections([.main])
                    self.snapshot.appendItems(data.list, toSection: .main)
                    self.datasource.apply(self.snapshot)
                    self.cycle = data.cycle
                } catch {
                    print("🚨", error)
                }
            }
    }

    private func post<T: Encodable>(with data: T) {
        let database = Firestore.firestore()
        let path = "/StudyGroup/w2sEujplXcqubgaYYUdZ/Members/R2kwDarTzaudc5JnGpL5/Homeworks/0mo72FPYAitcvpwnKQEI"
        do {
            let encodeData = try Firestore.Encoder().encode(data)
            database.document(path)
                .setData(encodeData) { error in
                    print("🚨", error as Any)
                }
        } catch {
            print("🚨", error)
        }
    }

    private func setupNavigationRightButton() -> UIMenu {
        let menu = UIMenu(options: [], children: [
            Menu.inviteTeam.action,
            Menu.editDate.action,
            Menu.editNickname(action: { [weak self] in
                let viewController = WriteNicknameViewController()
                viewController.mode = .edit
                self?.present(viewController, animated: true)
            }).action,
            Menu.leaveStudy(action: { [weak self] in
                let alert = UIAlertController(title: "스터디 탈퇴", message: "정말 스터디를 탈퇴하시겠습니까??", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .default))
                alert.addAction(UIAlertAction(title: "나가기", style: .destructive) { _ in
                    print("스터디 탈퇴")
                })
                self?.present(alert, animated: true, completion: nil)
            }).action
        ])
        return menu
    }
}

extension StudyRoomViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Member.testMemberList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StudyChartCollectionViewCell.className,
            for: indexPath) as? StudyChartCollectionViewCell else { assert(false, "do not have reusable view") }
        cell.setupCell(with: indexPath.item)
        return cell
    }
    
}

// MARK: - Homework List View

extension StudyRoomViewController: EditDelegate, CheckDelegate {

    func editButtonTapped() {
        let newViewController = UINavigationController(rootViewController: EditTaskViewController())
        present(newViewController, animated: true)
    }
    
    func checkDelegateButton(with indexPath: IndexPath) {
        guard let beforeItem = datasource.itemIdentifier(for: indexPath) else { return }
        var newItem = beforeItem
        newItem.isCompleted.toggle()
        
        snapshot.insertItems([newItem], afterItem: beforeItem)
        snapshot.deleteItems([beforeItem])
        let updatedItems = snapshot.itemIdentifiers
        
        let updatedHomeworks = Homeworks(cycle: cycle, list: updatedItems)
        post(with: updatedHomeworks)
    }
    
}
    
extension StudyRoomViewController: UICollectionViewDelegate {

    private func createHomeworkListViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: sectionHeaderElementKind,
            alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func configureHierachy() {
        let margin: CGFloat = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createHomeworkListViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layer.cornerRadius = 15
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            collectionView.topAnchor.constraint(equalTo: taskBackgroundView.bottomAnchor, constant: 26),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin)]
        )
    }

    private func configureDatasource() {
        let cellRegisteration = UICollectionView.CellRegistration<HomeworkListCell, Homework> { cell, indexPath, item in
            cell.checkDelegate = self
            cell.configureUI(with: item, index: indexPath)
        }

        datasource = Datasource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: item)
        })

        let headerRegisteration = UICollectionView.SupplementaryRegistration
        <HomeworkListTitleView>(elementKind: sectionHeaderElementKind) { supplymentaryView, _, _ in
            supplymentaryView.delegate = self
        }

        datasource.supplementaryViewProvider = { _, _, index in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegisteration, for: index)
        }
    }

    private func applySnapShot() {
        snapshot.appendSections([.main])
        snapshot.appendItems([Homework.mock], toSection: .main)
        datasource.apply(snapshot)
    }
    
}

struct StudyRoomViewControllerPreview: PreviewProvider {

    static var previews: some View {
        StudyRoomViewController().toPreview()
    }

}
