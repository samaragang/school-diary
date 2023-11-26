//
//  SettingsViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit
import SchoolDiaryUIComponents

enum SettingsType: CaseIterable {
    case notifications
    case signOut
    
    var cellType: SettingsTableViewCellType {
        switch self {
            case .notifications:
                return .switch
            case .signOut:
                return .button
        }
    }
    
    var title: String {
        switch self {
            case .notifications:
                return "Уведомления"
            case .signOut:
                return "Выход из аккаунта"
        }
    }
    
    var buttonImage: UIImage? {
        switch self {
            case .notifications:
                return nil
            case .signOut:
                return Constants.Images.signOutIcon.image
        }
    }
    
    var selectionStyle: UITableViewCell.SelectionStyle {
        switch self {
            case .notifications:
                return .none
            case .signOut:
                return .gray
        }
    }
}

final class SettingsViewController: BaseUIViewController {
    private lazy var userHeaderTableView: UserSettingsTableHeaderView = {
        let view = UserSettingsTableHeaderView()
        return view
    }()
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = userHeaderTableView
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        return tableView
    }()
    
    private let settings = SettingsType.allCases
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup interface methods
extension SettingsViewController {
    override func setupInterface() {
        super.setupInterface()
        self.navigationItem.title = "Настройки"
    }
    
    override func setupLayout() {
        self.view.addSubview(settingsTableView)
    }
    
    override func setupConstraints() {
        settingsTableView.snp.makeConstraints({ $0.edges.equalTo(self.view.safeAreaLayoutGuide).inset(UIEdgeInsets(vertical: 16)) })
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath)
        let type = self.settings[indexPath.row]
        (cell as? SettingsTableViewCell)?.setupCell(type: type) { switchValue in
            switch type {
                case .notifications:
                    break
                case .signOut:
                    guard SettingsManager.shared.signOut() else { return }
                    
                    MainCoordinator.shared.makeSignVCAsRoot()
            }
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
