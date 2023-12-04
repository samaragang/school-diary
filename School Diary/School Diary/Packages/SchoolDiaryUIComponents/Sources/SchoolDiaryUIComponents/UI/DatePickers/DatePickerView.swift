//
//  DatePickerView.swift
//
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import UIKit
import SnapKit

open class DatePickerView: BaseUIView {
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(didChangeValueAction), for: .valueChanged)
        datePicker.tintColor = UIColor(red: 0.35, green: 0.34, blue: 0.84, alpha: 1)
        return datePicker
    }()
    
    private let changeClosure: ((Date) -> ())?
    private let dismissClosure: (() -> ())?
    
    private var blurEffect: UIBlurEffect {
        return UIBlurEffect(style: self.traitCollection.userInterfaceStyle == .light ? .light : .dark)
    }
    
    private lazy var blurredEffectView: UIVisualEffectView = {
        return UIVisualEffectView(effect: self.blurEffect)
    }()
    
    public var date: Date? {
        didSet {
            guard let date else { return }
            
            self.datePicker.date = date
        }
    }
    
    public var minimumDate: Date? {
        didSet {
            self.datePicker.minimumDate = minimumDate
        }
    }
    
    private lazy var pickerHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addSubview(self.datePicker)
        return view
    }()
    
    public override init(frame: CGRect) {
        self.changeClosure = nil
        self.dismissClosure = nil
        super.init(frame: frame)
        self.initialSetup()
    }
    
    public required init?(coder: NSCoder) {
        self.changeClosure = nil
        self.dismissClosure = nil
        super.init(coder: coder)
        self.initialSetup()
    }
    
    public init(changeClosure: ((Date) -> ())? = nil, dismissClosure: (() -> ())? = nil) {
        self.changeClosure = changeClosure
        self.dismissClosure = dismissClosure
        super.init(frame: .zero)
        self.initialSetup()
    }
    
    private func initialSetup() {
        blurredEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
}

// MARK: - Setup interface methods
extension DatePickerView {
    open override func setupLayout() {
        self.addSubview(blurredEffectView)
        self.addSubview(pickerHolderView)
    }
    
    open override func setupConstraints() {
        blurredEffectView.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        pickerHolderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.centerY.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints({ $0.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: 20, vertical: 20)) })
    }
}

// MARK: - Actions
fileprivate extension DatePickerView {
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        dismissClosure?()
    }
    
    @objc func didChangeValueAction(_ sender: UIDatePicker) {
        changeClosure?(sender.date)
    }
}
