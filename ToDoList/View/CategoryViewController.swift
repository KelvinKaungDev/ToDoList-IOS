import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var category = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cateogry", for: indexPath)
        let cateogries = category[indexPath.row]
        cell.textLabel?.text = cateogries.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Lists", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let lists = segue.destination as! ListViewController
        
        if let index = tableView.indexPathForSelectedRow {
            lists.selectedCategory = category[index.row]
        }
    }
    
    //MARK: - Add Category
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var tempCategory = UITextField()
        
        let alert = UIAlertController(title: "Add Your Daily Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Caetgory", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = tempCategory.text!
            self.category.append(newCategory)
            
            self.saveList()
            self.tableView.reloadData()
        }
        
        alert.addTextField { (n) in
            n.placeholder = "Add Category"
            tempCategory = n
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func saveList() {
        do {
            try self.context.save()
        } catch {
            print("error \(error)")
        }
    }
    
    func loadData() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do {
            try category = context.fetch(request)
        } catch {
            print("error", error)
        }
    }
   
}
