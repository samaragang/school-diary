//
//  ScheduleViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import UIKit
import SchoolDiaryUIComponents

protocol ScheduleViewControllerProtocol: AnyObject {
    func reloadData()
    func popViewController()
    func refreshScreen()
    func reloadMenuButton()
}

final class ScheduleViewController: BaseUIViewController {
    private lazy var scheduleTableHeaderView: ScheduleTableHeaderView = {
        let view = ScheduleTableHeaderView()
        view.topColor = self.presenter?.headerColor
        return view
    }()
    
    private lazy var scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = self.scheduleTableHeaderView
        tableView.estimatedSectionHeaderHeight = 60
        tableView.register(ScheduleTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return tableView
    }()
    
    private lazy var leftWeekNavigationButton = {
        let button = UIButton()
        button.setImage(Constants.Images.leftBottomNavigationButtonIcon.image, for: .normal)
        button.isEnabled = self.presenter?.isLeftNavigationButtonEnabled ?? false
        button.tag = 1
        button.addTarget(self, action: #selector(bottomNavigationButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var dayLabel: LabelInView = {
        let weekDaysView = LabelInView()
        weekDaysView.text = self.presenter?.dayText
        return weekDaysView
    }()
    
    private lazy var rightWeekNavigationButton = {
        let button = UIButton()
        button.setImage(Constants.Images.rightBottomNavigationButtonIcon.image, for: .normal)
        button.isEnabled = self.presenter?.isRightNavigationButtonEnabled ?? false
        button.tag = 2
        button.addTarget(self, action: #selector(bottomNavigationButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private var presenter: SchedulePresenterProtocol?
    
    init(dayType: TimetableDaysType, day: Date, isCurrentWeek: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = SchedulePresenter(day: dayType, date: day, isCurrentWeek: isCurrentWeek, view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scheduleTableView.estimatedRowHeight = ScheduleTableViewCell.cellHeight
        scheduleTableView.rowHeight = UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

// MARK: -
// MARK: Setup interface methods
extension ScheduleViewController {
    override func setupInterface() {
        super.setupInterface()
        self.setupNavigationController()
    }
    
    override func setupLayout() {
        self.view.addSubview(scheduleTableView)
        self.view.addSubview(leftWeekNavigationButton)
        self.view.addSubview(dayLabel)
        self.view.addSubview(rightWeekNavigationButton)
    }
    
    override func setupConstraints() {
        scheduleTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(60 + (self.presenter?.tableViewHeight ?? 0) + 8)
            make.bottom.equalTo(dayLabel.snp.top).offset(-26)
        }
        
        leftWeekNavigationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(19)
            make.width.equalTo(11)
            make.centerY.equalTo(dayLabel.snp.centerY)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-33)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(167)
        }
        
        rightWeekNavigationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(19)
            make.width.equalTo(11)
            make.centerY.equalTo(dayLabel.snp.centerY)
        }
    }
    
    private func setupNavigationController() {
        self.navigationItem.title = self.presenter?.navigationTitle
        guard RealmManager<LocalUserModel>().read().first?.role == .teacher else { return }
        
        let barButtonItem = UIBarButtonItem(image: Constants.Images.menuNavigationButtonIcon.image, menu: self.presenter?.menuButton)
        barButtonItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
}

// MARK: - Actions
private extension ScheduleViewController {
    @objc func bottomNavigationButtonDidTap(_ sender: UIButton) {
        self.presenter?.bottomNavigationButtonDidTap(tag: sender.tag)
    }
}

// MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.lessonsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.id, for: indexPath)
        self.presenter?.configureCell(cell, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDatasource
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.didSelect(at: indexPath)
    }
}

// MARK: - ScheduleViewControllerProtocol
extension ScheduleViewController: ScheduleViewControllerProtocol {
    func reloadData() {
        self.scheduleTableView.reloadData()
    }
    
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func refreshScreen() {
        self.leftWeekNavigationButton.isEnabled = self.presenter?.isLeftNavigationButtonEnabled ?? false
        self.rightWeekNavigationButton.isEnabled = self.presenter?.isRightNavigationButtonEnabled ?? false
        self.navigationItem.title = self.presenter?.navigationTitle
        self.dayLabel.text = self.presenter?.dayText
        self.scheduleTableHeaderView.topColor = self.presenter?.headerColor
    }
    
    func reloadMenuButton() {
        let barButtonItem = UIBarButtonItem(image: Constants.Images.menuNavigationButtonIcon.image, menu: self.presenter?.menuButton)
        barButtonItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
}

@available(iOS 17.0, *)
#Preview {
    return ScheduleViewController(
        dayType: .tuesday,
        day: Date.day(.tuesday, isCurrentWeek: true),
        isCurrentWeek: true
    ).configureNavigationController(preferesLargeTitles: false)
}
