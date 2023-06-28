//
//  ViewController.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 29.06.2023.
//

import UIKit
import UserNotifications

class ViewController: UICollectionViewController, AddMemoDelegate, DeleteMemoDelegate, UpdateMemoDelegate {
    

    private var MemoSectionInfo: [MemoItemModel] = []

    private let shortMemoSectionIdentifier = "ShortMemoViewCell"

    private typealias DataSourceType = UICollectionViewDiffableDataSource<Int, MemoItemModel.ID>
    private var dataSource: DataSourceType!
    private static let defaultSectionIndex = 0

    private var storageController = StorageController()

    public init() {
        super.init(collectionViewLayout: Self.createLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(Coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = createDataSource()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))

        title = NSLocalizedString("Memories", comment: "")
        collectionView.backgroundColor = .systemBackground

        collectionView.register(ShortMemoViewCell.self, forCellWithReuseIdentifier: "ShortMemoViewCell")
        collectionView.register(AddMemoButtonViewCell.self, forCellWithReuseIdentifier: "AddMemoButtonViewCell")

        self.update()
        self.updateCollectionView()
    }

    private func update() {
        MemoSectionInfo.removeAll()
        MemoSectionInfo = storageController.getMemos()
        MemoSectionInfo.reverse()
//        collectionView.reloadData()
    }
    
    private func updateCollectionView() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MemoItemModel.ID>()
        snapshot.appendSections([Self.defaultSectionIndex])
        
        let itemIdentifiers = MemoSectionInfo.map { $0.id }
        
        snapshot.appendItems(itemIdentifiers, toSection: Self.defaultSectionIndex)
        
        dataSource.apply(snapshot)
        
        snapshot.reconfigureItems(itemIdentifiers)
        dataSource.apply(snapshot)
    }


    private static func createLayout() -> UICollectionViewCompositionalLayout {
        return .init { sectionIndex, environment in
            switch sectionIndex {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 16, bottom: 32, trailing: 16)
                section.interGroupSpacing = 16
                return section
            default:
                return nil
            }
        }
    }

    private func createDataSource() -> DataSourceType {
        return .init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.shortMemoSectionIdentifier, for: indexPath) as? ShortMemoViewCell
            cell?.update(self.MemoSectionInfo[indexPath.item])
            return cell
        }
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullMemoController = FullMemoInfoViewController(memoInfo: MemoSectionInfo[indexPath.item])
        fullMemoController.deleteMemoDelegate = self
        fullMemoController.updateMemoDelegate = self
        navigationController?.pushViewController(fullMemoController, animated: true)
    }

    @objc public func addItem() {
        let addMemoController = AddMemoViewController()
        addMemoController.addMemoDelegate = self
        navigationController?.pushViewController(addMemoController, animated: true)
    }
    
    func addMemo(memo: MemoItemModel) {
        MemoSectionInfo.append(memo)
        MemoSectionInfo = MemoSectionInfo.sorted(by: { $0.addDate ?? Date() > $1.addDate ?? Date()})
        self.updateCollectionView()
    }
    
    func deleteMemo(id: UUID?) {
        MemoSectionInfo = MemoSectionInfo.filter() { $0.id != id }
        self.updateCollectionView()
    }
    
    func updateMemo(memo: MemoItemModel) {
        MemoSectionInfo = MemoSectionInfo.filter() { $0.id != memo.id }
        MemoSectionInfo.append(memo)
        MemoSectionInfo = MemoSectionInfo.sorted(by: { $0.addDate ?? Date() > $1.addDate ?? Date()})
        self.updateCollectionView()
    }
    

}
