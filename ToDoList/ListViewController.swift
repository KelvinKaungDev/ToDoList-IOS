import UIKit

class ListViewController: UITableViewController {
    
    var lists = [List]()

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userList = List()
        userList.title = "Studying"
        userList.done = true
        lists.append(userList)
        
        let userList1 = List()
        userList1.title = "Dying"
        lists.append(userList1)
//        if let userLists = defaults.array(forKey: "userList") {
//            lists = userLists as! [String]
//        }
    }
}

//For the Table View and Cell

extension ListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lists", for: indexPath)
        let title = lists[indexPath.row]
        cell.textLabel?.text = title.title
        
        cell.accessoryType = title.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lists[indexPath.row].done = !lists[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
   }
}

//For the Local Storage for User List

extension ListViewController {
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        var newLists = UITextField()
        let alert =  UIAlertController(title: "Add To Do List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add List", style: .default) { (action) in
            let userList = List()
            userList.title = newLists.text!
            self.lists.append(userList)
            self.defaults.set(self.lists, forKey: "userList")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (n) in
            n.placeholder = "Add Item List"
            newLists = n
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

