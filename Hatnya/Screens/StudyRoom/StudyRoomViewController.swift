//
//  StudyRoomViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

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
    private let everyTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "모두의 숙제 현황"
        label.font = UIFont.systemFont(ofSize: 18)
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
    private let chartView = StudyChartView()
    private let codeCopyButton: UIButton = {
        let button = UIButton(type: .system)
        let action = UIAction { _ in
            UIPasteboard.general.string = "초대코드"
        }
        button.setTitle("초대 코드 복사", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - HomeworkList property
    
    private let sectionHeaderElementKind = "section-header-element-kind"
    
    enum HomeworkSection {
        case main
    }

    typealias Datasource = UICollectionViewDiffableDataSource<HomeworkSection, Homework>
    typealias Snapshot = NSDiffableDataSourceSnapshot<HomeworkSection, Homework>
    
    private var collectionView: UICollectionView!
    private var datasource: Datasource!
    private var snapshot = Snapshot()
    
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

    private func setupNavigationRightButton() -> UIMenu {
        let menu = UIMenu(options: [], children: [
            Menu.inviteTeam.action,
            Menu.editDate.action,
            Menu.editNickname(action: { [weak self] in
                let viewController = WriteNicknameViewController()
                viewController.isEditMode = true
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

// MARK: - Homework List View

extension StudyRoomViewController: UICollectionViewDelegate, EditDelegate {

    func editButtonTapped() {
        let newViewController = UINavigationController(rootViewController: EditTaskViewController())
        present(newViewController, animated: true)
    }

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
        collectionView.layer.borderWidth = 0.5
        collectionView.layer.borderColor = UIColor.gray.cgColor
        collectionView.layer.cornerRadius = 15
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            collectionView.topAnchor.constraint(equalTo: codeCopyButton.bottomAnchor, constant: margin),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin)]
        )
    }
    
    private func configureDatasource() {
        let cellRegisteration = UICollectionView.CellRegistration<HomeworkListCell, Homework> { cell, indexPath, item in
            cell.configureContent(item: item, index: indexPath.row)
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
        snapshot.appendItems(HomeworkMockData.longList, toSection: .main)
        datasource.apply(snapshot)
    }
    
}

struct StudyRoomViewControllerPreview: PreviewProvider {
    
    static var previews: some View {
        StudyRoomViewController().toPreview()
    }

}
