//
//  ChooseMarkViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SchoolDiaryUIComponents

typealias ChooseMarkCompletion = ((_ mark: MarkType) -> ())

final class ChooseMarkViewController: BaseUIViewController {
    private lazy var pupilLabel: LabelInView = {
        let label = LabelInView()
        label.text = pupil.nameAndSurname
        return label
    }()
    
    private lazy var marksCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 76, height: 62)
        collectionViewLayout.minimumLineSpacing = 16
        collectionViewLayout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isScrollEnabled = false
        collectionView.register(MarkCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let marks = MarkType.allCasesWithoutZero
    private let pupil: ResponseShortUserInfoModel
    private let completion: ChooseMarkCompletion
    
    init(withPupil pupil: ResponseShortUserInfoModel, completion: @escaping ChooseMarkCompletion) {
        self.pupil = pupil
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup interface methods
extension ChooseMarkViewController {
    override func setupLayout() {
        self.view.addSubview(pupilLabel)
        self.view.addSubview(marksCollectionView)
    }
    
    override func setupConstraints() {
        pupilLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(UIEdgeInsets(horizontal: 36, vertical: 24))
            make.height.equalTo(44)
        }
        
        marksCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.top.equalTo(pupilLabel.snp.bottom).offset(100)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-24)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ChooseMarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarkCollectionViewCell.id, for: indexPath)
        (cell as? MarkCollectionViewCell)?.configure(withMark: marks[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ChooseMarkViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.completion(self.marks[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
