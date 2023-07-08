import UIKit
import RealmSwift

class ListViewController: UITableViewController {
    
    var lists : Results<UserList>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadListData()
        }
    }
    
    @IBOutlet weak var userInput: UISearchBar!

    override func viewDidLoad() {
        userInput.delegate = self
        super.viewDidLoad()
    }
}

//MARK: - Table View and Cell

extension ListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lists", for: indexPath)
        if let title = lists?[indexPath.row] {
            cell.textLabel?.text = title.title
            
            cell.accessoryType = title.done ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        context.delete(self.lists[indexPath.row])
//        self.lists.remove(at: indexPath.row)
        lists?[indexPath.row].done = !(lists?[indexPath.row].done)!
//        saveList()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
   }
    
}

//MARK: - Store User List

extension ListViewController {
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        var newLists = UITextField()
        let alert =  UIAlertController(title: "Add To Do List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add List", style: .default) { [self] (action) in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let userList = UserList()
                        userList.title = newLists.text!
                        userList.done = false
                        currentCategory.userList.append(userList)
                    }
                } catch {
                    print("error \(error)")
                }
               
                self.tableView.reloadData()
            }
            
        }
        
        alert.addTextField { (n) in
            n.placeholder = "Add Item List"
            newLists = n
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func saveList(with list : UserList) {
        do {
            try realm.write {
                realm.add(list)
            }
        } catch {
            print("error \(error)")
        }
        
    }
    
    func loadListData() {
        lists = selectedCategory?.userList.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

//MARK: - Search bar

extension ListViewController : UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<List> = List.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = predicate
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadListData(with: request,predicate: predicate)
//    }
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadListData()
            DispatchQueue.main.async {
                searchBar.endEditing(true)
            }
        }
    }
}




