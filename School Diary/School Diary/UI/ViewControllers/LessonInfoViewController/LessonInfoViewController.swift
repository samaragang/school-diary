//
//  LessonInfoViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 30.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class LessonInfoViewController: BaseUIViewController {
    private lazy var dateLabel: LabelInView = {
        let label = LabelInView()
        label.text = "\(self.dateType.fullTitle) \(self.day.ddMMFormat)"
        return label
    }()
    
    private lazy var lessonThemeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Тема урока"
        label.textColor = self.dateType.backgroundColor
        return label
    }()
    
    private lazy var lessonThemeTextView: PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.placeholder = "Введите тему урока"
        textView.contentInset = UIEdgeInsets(horizontal: 16, vertical: 10)
        textView.layer.cornerRadius = 20
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        textView.placeholderColor = UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.6)
        return textView
    }()
    
    private lazy var lessonThemeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(lessonThemeLabel)
        stackView.addArrangedSubview(lessonThemeTextView)
        return stackView
    }()
    
    private lazy var lessonThemeContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.addSubview(lessonThemeStackView)
        view.backgroundColor = self.dateType.backgroundColor.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var hometaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Домашнее задание"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var dateHometaskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Дата"
        label.textColor = self.dateType.backgroundColor
        return label
    }()
    
    private lazy var dateHometaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("ДД/ММ/ГГ", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.6), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.titleEdgeInsets = UIEdgeInsets(horizontal: 16, vertical: 11)
        button.addTarget(self, action: #selector(presentDatePicker), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateHometaskContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = self.dateType.backgroundColor.withAlphaComponent(0.3)
        view.addSubview(dateHometaskLabel)
        view.addSubview(dateHometaskButton)
        return view
    }()
    
    private lazy var hometaskInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Примечание"
        label.textColor = self.dateType.backgroundColor
        return label
    }()
    
    private lazy var hometaskInfoTextView: UITextView = {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(horizontal: 16, vertical: 10)
        textView.layer.cornerRadius = 20
        textView.font = .systemFont(ofSize: 17, weight: .regular)
        return textView
    }()
    
    private lazy var hometaskInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(hometaskInfoLabel)
        stackView.addArrangedSubview(hometaskInfoTextView)
        return stackView
    }()
    
    private lazy var hometaskInfoContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.addSubview(hometaskInfoStackView)
        view.backgroundColor = self.dateType.backgroundColor.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var datePicker: DatePickerView = {
        let datePicker = DatePickerView { [weak self] date in
            self?.selectedDay = date
            self?.dateHometaskButton.setTitle(date.ddMMyyFormat, for: .normal)
            self?.dateHometaskButton.setTitleColor(.label, for: .normal)
        } dismissClosure: { [weak self] in
            UIView.animate(withDuration: 0.3) {
                self?.datePicker.alpha = 0
            } completion: { _ in
                self?.datePicker.isHidden = true
            }
        }

        datePicker.isHidden = true
        datePicker.alpha = 0
        datePicker.minimumDate = Date()
        return datePicker
    }()
    
    private let day: Date
    private let dateType: TimetableDaysType
    private let lesson: ResponseLessonModel
    private var selectedDay: Date?
    
    init(with lesson: ResponseLessonModel, day: Date, dateType: TimetableDaysType) {
        self.day = day
        self.dateType = dateType
        self.lesson = lesson
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let selectedDay,
              let hometask = self.hometaskInfoTextView.text
        else { return }
        
        SchoolsDiaryProvider.shared.addHometask(lesson: self.lesson, date: selectedDay, hometask: hometask)
    }
}

// MARK: - Setup interface methods
extension LessonInfoViewController {
    override func setupInterface() {
        super.setupInterface()
        self.setupNavigationController()
    }
    
    override func setupLayout() {
        self.view.addSubview(dateLabel)
        self.view.addSubview(lessonThemeContentView)
        self.view.addSubview(hometaskLabel)
        self.view.addSubview(dateHometaskContentView)
        self.view.addSubview(hometaskInfoContentView)
        self.view.addSubview(datePicker)
    }
    
    override func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 36))
            make.height.equalTo(44)
        }
        
        lessonThemeContentView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(112)
        }
        
        lessonThemeStackView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: 12, vertical: 10)) })
        
        hometaskLabel.snp.makeConstraints { make in
            make.top.equalTo(lessonThemeContentView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        
        dateHometaskContentView.snp.makeConstraints { make in
            make.top.equalTo(hometaskLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(68)
        }
        
        dateHometaskLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        
        self.view.layoutIfNeeded()
        
        dateHometaskButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(vertical: 10))
            make.width.equalTo(dateHometaskContentView.frame.width / 2)
        }
        
        hometaskInfoContentView.snp.makeConstraints { make in
            make.top.equalTo(dateHometaskContentView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(152)
        }
        
        hometaskInfoStackView.snp.makeConstraints({ $0.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: 12, vertical: 10)) })
        
        datePicker.snp.makeConstraints({ $0.edges.equalToSuperview() })
    }
    
    private func setupNavigationController() {
        self.navigationItem.title = self.lesson.className
    }
}

// MARK: - Actions
fileprivate extension LessonInfoViewController {
    @objc func presentDatePicker(_ sender: UIButton) {
        if let selectedDay {
            self.datePicker.date = selectedDay
        } else {
            self.datePicker.date = Date()
        }
        
        self.datePicker.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.datePicker.alpha = 1
        }
    }
}
