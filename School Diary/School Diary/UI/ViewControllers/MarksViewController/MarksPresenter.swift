//
//  MarksPresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 3.12.23.
//

import Foundation

protocol MarksPresenterProtocol {
    func viewDidLoad()
    func subject(at indexPath: IndexPath) -> ResponseSubjectMarkModel
    
    var subjectsCount: Int { get }
}

final class MarksPresenter: MarksPresenterProtocol {
    private let view: MarksViewControllerProtocol
    
    private var subjects = [ResponseSubjectMarkModel]()
    
    var subjectsCount: Int {
        return subjects.count
    }
    
    init(view: MarksViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        SchoolsDiaryProvider.shared.termMarks { [weak self] subjects in
            self?.subjects = subjects
            self?.view.reloadData()
        }
    }
    
    func subject(at indexPath: IndexPath) -> ResponseSubjectMarkModel {
        return self.subjects[indexPath.row]
    }
}
