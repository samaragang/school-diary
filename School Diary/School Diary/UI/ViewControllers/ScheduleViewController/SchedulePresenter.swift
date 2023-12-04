//
//  SchedulePresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 26.11.23.
//

import UIKit

protocol SchedulePresenterProtocol {
    var lessonsCount                  : Int { get }
    var tableViewHeight               : CGFloat { get }
    var navigationTitle               : String { get }
    var dayText                       : String { get }
    var headerColor                   : UIColor { get }
    var isLeftNavigationButtonEnabled : Bool { get }
    var isRightNavigationButtonEnabled: Bool { get }
    var menuButton                    : UIMenu? { get }
    
    func viewDidLoad()
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath)
    func bottomNavigationButtonDidTap(tag: Int)
    func didSelect(at indexPath: IndexPath)
}

final class SchedulePresenter: SchedulePresenterProtocol {
    private var lessons    = [ResponseLessonModel]()
    private var day        : TimetableDaysType
    private var date       : Date
    private weak var view  : ScheduleViewControllerProtocol?
    private let days       = TimetableDaysType.allCases
    private let daysArray  : [Date]
    private var currentMode: ScheduleMenuType = .createLesson
    
    var lessonsCount: Int {
        return self.lessons.count
    }
    
    var tableViewHeight: CGFloat {
        return CGFloat(self.lessonsCount) * ScheduleTableViewCell.cellHeight
    }
    
    var navigationTitle: String {
        return "\(self.day.title) \(self.date.ddMMFormat)"
    }
    
    var isLeftNavigationButtonEnabled: Bool {
        return self.day != .monday
    }
    
    var isRightNavigationButtonEnabled: Bool {
        return self.day != .saturday
    }
    
    var dayText: String {
        return self.day.fullTitle
    }
    
    var headerColor: UIColor {
        return self.day.backgroundColor
    }
    
    var menuButton: UIMenu? {
        let currentUserRole = RealmManager<LocalUserModel>().read().first?.role
        if RealmManager<LocalUserModel>().read().first?.role == .teacher {
            let createHometaskAction = UIAction(
                title: "Добавление домашнего задания",
                state: self.currentMode.actionState(for: .createLesson)
            ) { [weak self] _ in
                self?.currentMode = .createLesson
                self?.view?.reloadMenuButton()
            }
            
            let addMarkAction = UIAction(title: "Выставление оценок", state: self.currentMode.actionState(for: .addMark)) { [weak self] _ in
                self?.currentMode = .addMark
                self?.view?.reloadMenuButton()
            }
            
            return UIMenu(children: [createHometaskAction, addMarkAction])
        }
        
        return nil
    }
    
    init(day: TimetableDaysType, date: Date, isCurrentWeek: Bool, view: ScheduleViewControllerProtocol?) {
        self.day = day
        self.date = date
        self.view = view
        self.daysArray = isCurrentWeek ? Date.daysInCurrentWeek : Date.daysInNextWeek
    }
    
    func viewDidLoad() {
        SchoolsDiaryProvider.shared.schedule(for: day, shouldReturnHometask: true) { [weak self] lessons in
            self?.lessons = lessons
            self?.view?.reloadData()
        } failure: {
            self.view?.popViewController()
        }
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        (cell as? ScheduleTableViewCell)?.configure(withLesson: self.lessons[indexPath.row], forDate: self.date)
    }
    
    func bottomNavigationButtonDidTap(tag: Int) {
        var index = self.day.rawValue
        if tag == 1 {
            index -= 2
        }
        
        self.day = self.days[index]
        self.date = self.daysArray[index]
        self.view?.refreshScreen()
        SchoolsDiaryProvider.shared.schedule(for: day, shouldReturnHometask: true) { [weak self] lessons in
            self?.lessons = lessons
            self?.view?.reloadData()
        } failure: {
            self.view?.popViewController()
        }
    }
    
    func didSelect(at indexPath: IndexPath) {
        guard RealmManager<LocalUserModel>().read().first?.role == .teacher else { return }
        
        switch self.currentMode {
            case .createLesson:
                MainCoordinator.shared.pushLessonInfoViewController(
                    lesson: self.lessons[indexPath.row],
                    day: self.daysArray[indexPath.row],
                    dateType: self.days[indexPath.row]
                )
            case .addMark:
                MainCoordinator.shared.pushLessonMarksViewController(
                    lesson: self.lessons[indexPath.row],
                    day: self.daysArray[indexPath.row],
                    dateType: self.days[indexPath.row]
                )
            default:
                break
        }
    }
}
