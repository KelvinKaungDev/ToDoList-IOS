
import UIKit

class ListViewController: UITableViewController {
    
    var lists = ["Eating", "Sleeping"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Lists", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
   }
    
    @IBAction func addList(_ sender: UIBarButtonItem) {
        var newLists = UITextField()
        let alert =  UIAlertController(title: "Add To Do List", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add List", style: .default) { (action) in
            self.lists.append(newLists.text!)
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
