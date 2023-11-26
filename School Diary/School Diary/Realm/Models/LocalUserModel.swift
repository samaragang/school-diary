//
//  LocalUserModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation
import RealmSwift

class LocalUserModel: Object {
    @Persisted dynamic var roleRawType = 0
    @Persisted dynamic var name = ""
    @Persisted dynamic var surname = ""
    @Persisted dynamic var schoolId = 0
    @Persisted dynamic var userId = 0
    @Persisted dynamic var classId = 0
    @Persisted dynamic var phoneNumber = ""
    
    var role: RoleType {
        return RoleType(rawValue: self.roleRawType) ?? .none
    }
    
    var nameAndSurname: String {
        return "\(self.name) \(self.surname)"
    }
    
    convenience init(user: ResponseUserModel) {
        self.init(
            role: user.role, 
            name: user.name,
            surname: user.surname,
            schoolId: user.schoolId,
            userId: user.userId,
            classId: user.classId,
            phoneNumber: user.phoneNumber
        )
    }
    
    convenience init(teacher: ResponseUserBaseModel) {
        self.init(
            role: .teacher,
            name: teacher.name,
            surname: teacher.surname, 
            schoolId: teacher.schoolId, 
            userId: teacher.userId,
            classId: teacher.classId,
            phoneNumber: teacher.phoneNumber
        )
    }
    
    convenience init(
        role: RoleType,
        name: String,
        surname: String,
        schoolId: Int,
        userId: Int,
        classId: Int,
        phoneNumber: String
    ) {
        self.init()
        self.roleRawType = role.rawValue
        self.name = name
        self.surname = surname
        self.schoolId = schoolId
        self.userId = userId
        self.classId = classId
        self.phoneNumber = phoneNumber
    }
}
