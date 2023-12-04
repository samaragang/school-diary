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
    
    private lazy var timetableCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 16
        let cellSide = (UIScreen.main.bounds.width / 2) - 20 - 8
        flowLayout.itemSize = CGSize(width: cellSide, height: cellSide)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(TimetableCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var leftWeekNavigationButton = {
        let button = UIButton()
        button.setImage(Constants.Images.leftBottomNavigationButtonIcon.image, for: .normal)
        button.isEnabled = false
        button.tag = 1
        button.addTarget(self, action: #selector(bottomNavigationButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var weekDaysLabel: LabelInView = {
        let weekDaysView = LabelInView()
        weekDaysView.text = Date.currentWeekForLabel
        return weekDaysView
    }()
    
    private lazy var rightWeekNavigationButton = {
        let button = UIButton()
        button.setImage(Constants.Images.rightBottomNavigationButtonIcon.image, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(bottomNavigationButtonDidTap), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private var presenter: TimetableProtocol
    
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
        self.view.addSubview(leftWeekNavigationButton)
        self.view.addSubview(weekDaysLabel)
        self.view.addSubview(rightWeekNavigationButton)
    }
    
    override func setupConstraints() {
        timetableCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.bottom.equalTo(weekDaysLabel.snp.bottom).inset(24)
        }
        
        leftWeekNavigationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(19)
            make.width.equalTo(11)
            make.centerY.equalTo(weekDaysLabel.snp.centerY)
        }
        
        weekDaysLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-33)
            make.height.equalTo(44)
            make.width.equalTo(167)
        }
        
        rightWeekNavigationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(19)
            make.width.equalTo(11)
            make.centerY.equalTo(weekDaysLabel.snp.centerY)
        }
    }
    
    private func setupNavigationController() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.navigationTitleLabel)
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}

// MARK: - Actions
private extension TimetableViewController {
    @objc func bottomNavigationButtonDidTap(_ sender: UIButton) {
        leftWeekNavigationButton.isEnabled = sender.tag == 2
        rightWeekNavigationButton.isEnabled = sender.tag == 1
        self.presenter.isCurrentWeek = sender.tag == 1
        self.weekDaysLabel.text = sender.tag == 1 ? Date.currentWeekForLabel : Date.nextWeekForLabel
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

// MARK: - UICollectionViewDelegate
extension TimetableViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.collectionView(didSelectAt: indexPath)
    }
}

@available(iOS 17.0, *)
#Preview {
    return TimetableViewController()
}
