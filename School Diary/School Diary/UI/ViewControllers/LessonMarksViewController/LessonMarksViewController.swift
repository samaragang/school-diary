//
//  LessonMarksViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

protocol LessonMarksViewControllerProtocol {
    func popViewController()
    func reloadData()
    func updateMark(at indexPath: IndexPath, with mark: MarkType)
}

final class LessonMarksViewController: BaseUIViewController {
    private lazy var dateLabel: LabelInView = {
        let label = LabelInView()
        label.text = "\(self.dateType.fullTitle) \(self.day.ddMMFormat)"
        return label
    }()
    
    private lazy var lessonTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Тип занятия"
        label.textColor = self.dateType.backgroundColor
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var lessonTypeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.setTitle(self.lessonType.rawValue, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.contentHorizontalAlignment = .leading
        button.titleEdgeInsets = UIEdgeInsets(horizontal: 16, vertical: 11)
        button.showsMenuAsPrimaryAction = true
        button.menu = self.lessonTypeMenu
        return button
    }()
    
    private lazy var lessonInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(lessonTypeLabel)
        stackView.addArrangedSubview(lessonTypeButton)
        return stackView
    }()
    
    private lazy var lessonInfoContentView: UIView = {
        let view = UIView()
        view.backgroundColor = self.dateType.backgroundColor.withAlphaComponent(0.3)
        view.layer.cornerRadius = 12
        view.addSubview(lessonInfoStackView)
        return view
    }()
    
    private lazy var pupilLabel: UILabel = {
        let label = UILabel()
        label.text = "Ученики"
        label.textColor = self.dateType.backgroundColor
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var pupilsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(PupilMarkTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        return tableView
    }()
    
    private lazy var pupilsContentView: UIView = {
        let view = UIView()
        view.backgroundColor = self.dateType.backgroundColor.withAlphaComponent(0.3)
        view.layer.cornerRadius = 12
        view.addSubview(pupilLabel)
        view.addSubview(pupilsTableView)
        return view
    }()
    
    private let dateType: TimetableDaysType
    private let day: Date
    private let lesson: ResponseLessonModel
    private var lessonType: LessonType = .lessonInClass {
        didSet {
            self.lessonTypeButton.setTitle(lessonType.rawValue, for: .normal)
            self.lessonTypeButton.menu = self.lessonTypeMenu
        }
    }
    
    private var lessonTypeMenu: UIMenu {
        var actions = [UIAction]()
        LessonType.allCases.forEach { [weak self] lessonType in
            actions.append(UIAction(title: lessonType.rawValue, state: lessonType.actionState(for: self?.lessonType), handler: { _ in
                self?.lessonType = lessonType
            }))
        }
        
        return UIMenu(title: "Тип занятия", children: actions)
    }
    
    private lazy var presenter: LessonMarksPresenterProtocol = {
        return LessonMarksPresenter(lesson: self.lesson, date: self.day, view: self)
    }()
    
    init(lesson: ResponseLessonModel, date: Date, type dateType: TimetableDaysType) {
        self.lesson = lesson
        self.day = date
        self.dateType = dateType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.viewWillDisappear()
    }
}

// MARK: - Setup interface methods
extension LessonMarksViewController {
    override func setupInterface() {
        super.setupInterface()
        self.setupNavigationController()
    }
    
    override func setupLayout() {
        self.view.addSubview(dateLabel)
        self.view.addSubview(lessonInfoContentView)
        self.view.addSubview(pupilsContentView)
    }
    
    override func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 36))
            make.height.equalTo(44)
        }
        
        lessonInfoContentView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(96)
        }
        
        lessonInfoStackView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: 12, vertical: 12)) })
        
        pupilsContentView.snp.makeConstraints { make in
            make.top.equalTo(lessonInfoContentView.snp.bottom).offset(29)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
        
        pupilLabel.snp.makeConstraints({ $0.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 12, vertical: 12)) })
        
        pupilsTableView.snp.makeConstraints { make in
            make.top.equalTo(pupilLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigationController() {
        self.navigationItem.title = self.lesson.className
    }
}

// MARK: - UITableViewDataSource
extension LessonMarksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.usersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PupilMarkTableViewCell.id, for: indexPath)
        (cell as? PupilMarkTableViewCell)?.configure(user: self.presenter.user(for: indexPath), dayType: self.dateType)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LessonMarksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelect(at: indexPath)
    }
}

// MARK: - LessonMarksViewControllerProtocol
extension LessonMarksViewController: LessonMarksViewControllerProtocol {
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadData() {
        self.pupilsTableView.reloadData()
    }
    
    func updateMark(at indexPath: IndexPath, with mark: MarkType) {
        (self.pupilsTableView.cellForRow(at: indexPath) as? PupilMarkTableViewCell)?.updateMark(mark)
    }
}
