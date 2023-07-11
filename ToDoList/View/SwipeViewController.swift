
import UIKit
import SwipeCellKit

private let reuseIdentifier = "Cell"

class SwipeViewController: UITableViewController, SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.updateSwipe(at: indexPath)
        }

        deleteAction.image = UIImage(named: "trash-circle")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
    func updateSwipe(at indexPath : IndexPath) {
       print("Deleted")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
