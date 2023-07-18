//
//  AddMemoViewController.swift
//  ToDo
//
//  Created by Матвей Кузнецов on 07.07.2023.
//

import UIKit
import UserNotifications
import Combine

public protocol AddMemoDelegate: AnyObject {
    func addMemo(memo: MemoItemModel)
}

class AddMemoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var addMemoDelegate: AddMemoDelegate?
    
    private let LabelFieldIdentifer = "LabelFieldViewCell"
    private let TextFieldIdentifer = "TextFieldViewCell"
    private let DateFieldIdentifer = "DateFieldViewCell"
    private let SaveButtonIdentifer = "SaveButtonViewCell"
    
    private var labelCell = LabelFieldViewCell()
    private var textCell = TextFieldViewCell()
    private var dateCell = DateFieldViewCell()
    
    private var tableView: UITableView!
    
    private var storageController = StorageController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Add Memo", comment: "")
        view.backgroundColor = .systemBackground
        
        tableView = UITableView(frame: view.frame, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        view = tableView
        
        self.hideKeyboardWhenTappedAround()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        tableView.register(LabelFieldViewCell.self, forCellReuseIdentifier: LabelFieldIdentifer)
        tableView.register(TextFieldViewCell.self, forCellReuseIdentifier: TextFieldIdentifer)
        tableView.register(DateFieldViewCell.self, forCellReuseIdentifier: DateFieldIdentifer)
        tableView.register(SaveButtonViewCell.self, forCellReuseIdentifier: SaveButtonIdentifer)
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.tableView.endEditing(true)
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LabelFieldIdentifer, for: indexPath) as! LabelFieldViewCell
            cell.selectionStyle = .none
            labelCell = cell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldIdentifer, for: indexPath) as! TextFieldViewCell
            cell.selectionStyle = .none
            textCell = cell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DateFieldIdentifer, for: indexPath) as! DateFieldViewCell
            cell.selectionStyle = .none
            dateCell = cell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: SaveButtonIdentifer, for: indexPath) as! SaveButtonViewCell
            cell.selectionStyle = .none
            cell.SaveButton.addTarget(self, action: #selector(self.saveInfo), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func saveInfo() {
        let labelInfo = labelCell.getInfo()
        let textInfo = textCell.getInfo()
        let dateInfo = dateCell.getInfo()
        cellInfo(labelInfo, textInfo, dateInfo)
    }
    
    
    func cellInfo(_ Label: UITextField, _ Text: UITextView, _ DueDate: UIDatePicker) {
        let AddMemoInfo = MemoItemModel(dueDate: DueDate.date, addDate: Date(), id: UUID(), text: Text.text, label: Label.text)
        toggleSaved(AddMemoInfo)
    }
    
    private func toggleSaved(_ AddMemoInfo: MemoItemModel){
        self.addMemoDelegate?.addMemo(memo: AddMemoInfo)
        AddMemoInfo.updateNotifications()
        storageController.insertMemo(AddMemoInfo)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String?
        switch section {
            case 0:
                sectionName = NSLocalizedString("titel", comment: "")
            case 1:
                sectionName = NSLocalizedString("text", comment: "")
            case 2:
                sectionName = NSLocalizedString("date and time of the event", comment: "")
            case 3:
                sectionName = nil
            default:
                sectionName = nil
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 2:
                return
            case 3:
                return
            default:
                cell.contentView.backgroundColor = UIColor.clear
                cell.backgroundColor = .systemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
}
