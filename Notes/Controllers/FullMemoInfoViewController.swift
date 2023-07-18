//
//  FullMemoInfoViewController.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 07.07.2023.
//

import UIKit
import UserNotifications

public protocol DeleteMemoDelegate: AnyObject {
    func deleteMemo(id: UUID?)
}

class FullMemoInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateMemoDelegate {
    
    
    weak var deleteMemoDelegate: DeleteMemoDelegate?
    weak var updateMemoDelegate: UpdateMemoDelegate?
    
    private let LabelInfodentifer = "LabelInfoViewCell"
    private let TextInfoViewIdentifer = "TextInfoViewCell"
    private let DueDateInfoIdentifer = "DueDateInfoViewCell"
    private let AddDateInfoIdentifer = "AddDateInfoViewCell"
    private let ButtonsIdentifer = "ButtonsViewCell"
    
    private var MemoInfo: MemoItemModel!
    
    private var tableView: UITableView!
    
    private var storageController = StorageController()
    
    init(memoInfo: MemoItemModel) {
        MemoInfo = memoInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Memo", comment: "")
        view.backgroundColor = .systemBackground
        
        tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        view = tableView
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.register(LabelInfoViewCell.self, forCellReuseIdentifier: LabelInfodentifer)
        tableView.register(TextInfoViewCell.self, forCellReuseIdentifier: TextInfoViewIdentifer)
        tableView.register(DueDateInfoViewCell.self, forCellReuseIdentifier: DueDateInfoIdentifer)
        tableView.register(AddDateInfoViewCell.self, forCellReuseIdentifier: AddDateInfoIdentifer)
        tableView.register(ButtonsViewCell.self, forCellReuseIdentifier: ButtonsIdentifer)
        
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelInfodentifer, for: indexPath) as! LabelInfoViewCell
            cell.selectionStyle = .none
            cell.update(MemoInfo.label)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextInfoViewIdentifer, for: indexPath) as! TextInfoViewCell
            cell.selectionStyle = .none
            cell.update(MemoInfo.text)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DueDateInfoIdentifer, for: indexPath) as! DueDateInfoViewCell
            cell.selectionStyle = .none
            cell.update(MemoInfo.dueDate)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDateInfoIdentifer, for: indexPath) as! AddDateInfoViewCell
            cell.selectionStyle = .none
            cell.update(MemoInfo.addDate)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonsIdentifer, for: indexPath) as! ButtonsViewCell
            cell.selectionStyle = .none
            cell.DeleteButton.addTarget(self, action: #selector(self.Delete), for: .touchUpInside)
            cell.UpdateButton.addTarget(self, action: #selector(self.Update), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func Delete() {
        self.deleteMemoDelegate?.deleteMemo(id: MemoInfo.id ?? nil)
        storageController.removeMemo(MemoInfo.id)
        MemoInfo.dueDate = nil
        MemoInfo.updateNotifications()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func Update() {
        let updateMemoController = UpdateMemoViewController(memoInfo: MemoInfo)
        updateMemoController.updateMemoDelegate = self
        navigationController?.pushViewController(updateMemoController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("titel", comment: "")
            case 1:
                sectionName = NSLocalizedString("text", comment: "")
            case 2:
                sectionName = NSLocalizedString("date and time of the event", comment: "")
            case 3:
                sectionName = NSLocalizedString("date and time of creation", comment: "")
            case 4:
                sectionName = ""
            default:
                sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 4:
                return
            default:
                cell.contentView.backgroundColor = UIColor.clear
                cell.backgroundColor = .systemBackground
        }
    }
    
    func updateMemo(memo: MemoItemModel) {
        MemoInfo = memo
        self.updateMemoDelegate?.updateMemo(memo: MemoInfo)
        tableView.reloadData()
    }
    
}

