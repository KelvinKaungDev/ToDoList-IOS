import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name : String = ""
    var userList = List<UserList>()
}
