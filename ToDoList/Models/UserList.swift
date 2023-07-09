import Foundation
import RealmSwift

class UserList : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    var parentCategory = LinkingObjects(fromType: Category.self, property: "userList")
}
