//
//  TimetableViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class TimetableViewController: BaseUIViewController {
    private lazy var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private lazy var menuNavigationButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.Images.menuNavigationButtonIcon.image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private lazy var timetableCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        let cellSide = (UIScreen.main.bounds.width / 2) - 20 - 8
        flowLayout.itemSize = CGSize(width: cellSide, height: cellSide)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(TimetableCollectionViewCell.self)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var weekDaysView: WeekDaysView = {
        let weekDaysView = WeekDaysView()
        weekDaysView.weekDays = Date.currentWeekForLabel
        return weekDaysView
    }()
    
    private let presenter: TimetableProtocol
    
    init() {
        self.presenter = TimetablePresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup interface methods
extension TimetableViewController {
    override func setupInterface() {
        super.setupInterface()
        self.setupNavigationController()
    }
    
    override func setupLayout() {
        self.view.addSubview(timetableCollectionView)
        self.view.addSubview(weekDaysView)
    }
    
    override func setupConstraints() {
        timetableCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.bottom.equalTo(weekDaysView.snp.bottom).inset(24)
        }
        
        weekDaysView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-33)
            make.height.equalTo(44)
            make.width.equalTo(167)
        }
    }
    
    private func setupNavigationController() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.navigationTitleLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.menuNavigationButton)
    
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}

// MARK: - UICollectionViewDataSource
extension TimetableViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TimetableDaysType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimetableCollectionViewCell.id, for: indexPath)
        (cell as? TimetableCollectionViewCell)?.configure(withDay: self.presenter.day(at: indexPath))
        return cell
    }
}
