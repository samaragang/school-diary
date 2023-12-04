//
//  MarksViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

protocol MarksViewControllerProtocol {
    func reloadData()
}

final class MarksViewController: BaseUIViewController {
    private lazy var marksTableHeaderView: MarksTableHeaderView = {
        let view = MarksTableHeaderView()
        return view
    }()
    
    private lazy var marksTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = self.marksTableHeaderView
        tableView.estimatedSectionHeaderHeight = 60
        tableView.register(SubjectMarksTableViewCell.self)
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return tableView
    }()
    
    private lazy var presenter: MarksPresenterProtocol = {
        let presenter = MarksPresenter(view: self)
        return presenter
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
}

// MARK: - Setup interface methods
extension MarksViewController {
    override func setupLayout() {
        self.view.addSubview(marksTableView)
    }
    
    override func setupConstraints() {
        marksTableView.snp.makeConstraints({ $0.edges.equalTo(self.view.safeAreaLayoutGuide).inset(UIEdgeInsets(horizontal: 20, vertical: 26)) })
    }
}

// MARK: - UITableViewDataSource
extension MarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.subjectsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SubjectMarksTableViewCell.id, for: indexPath)
        (cell as? SubjectMarksTableViewCell)?.configure(subject: self.presenter.subject(at: indexPath))
        return cell
    }
}

// MARK: - MarksViewControllerProtocol
extension MarksViewController: MarksViewControllerProtocol {
    func reloadData() {
        self.marksTableView.reloadData()
    }
}
