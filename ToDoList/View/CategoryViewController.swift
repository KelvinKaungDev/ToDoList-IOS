import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: SwipeViewController{
    
    var category : Results<Category>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.rowHeight = 80.0
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cateogry", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        let cateogries = category?[indexPath.row]
        cell.textLabel?.text = cateogries?.name ?? "Your Category is empty"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Lists", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lists = segue.destination as! ListViewController

        if let index = tableView.indexPathForSelectedRow {
            lists.selectedCategory = category?[index.row]
        }
    }

//    MARK: - Add Category
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var tempCategory = UITextField()
        
        let alert = UIAlertController(title: "Add Your Daily Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Caetgory", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = tempCategory.text!
            
            self.saveList(c: newCategory)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (n) in
            n.placeholder = "Add Category"
            tempCategory = n
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func saveList(c : Category) {
        do {
            try realm.write {
                realm.add(c)
            }
        } catch {
            print("error \(error)")
        }
    }
    
    func loadData() {
        category = realm.objects(Category.self)
    
        self.tableView.reloadData()
    }
    
    override func updateSwipe(at indexPath: IndexPath) {
        super.updateSwipe(at: indexPath)
        
        if let deleteCategory = category?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(deleteCategory)
                }
            } catch {
                print(error)
            }
        }
    }
   
}


