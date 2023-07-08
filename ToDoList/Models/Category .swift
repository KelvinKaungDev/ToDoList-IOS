import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name : String = ""
    let userList = List<UserList>()
}
