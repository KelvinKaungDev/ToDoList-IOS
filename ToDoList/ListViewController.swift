import UIKit

class ListViewController: UITableViewController {
    
    var lists = [List]()

    let localStorage = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension("lists.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadListData()
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
        self.localstorageUpdate()
        
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
            self.localstorageUpdate()
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (n) in
            n.placeholder = "Add Item List"
            newLists = n
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func localstorageUpdate() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(lists)
            try data.write(to: localStorage!)
        } catch {
            print("error \(error)")
        }
        
    }
    
    func loadListData() {
        let data = try? Data(contentsOf: self.localStorage!)
        let decoder = PropertyListDecoder()
        do {
            let result = try decoder.decode([List].self, from: data!)
            lists = result
        } catch {
            print("error \(error)")
        }
    }
}


