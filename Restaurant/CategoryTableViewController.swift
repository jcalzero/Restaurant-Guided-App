import UIKit

class CategoryTableViewController: UITableViewController {
    var categories = [String]()
    
    var menuItems = [MenuItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuController.shared.fetchMenuItems() { (menuItems) in
            if let menuItems = menuItems {
                for item in menuItems {
                    let category = item.category
                    
                    if !self.categories.contains(category) {
                        self.categories.append(category)
                    }
                }
                
                self.menuItems = menuItems
                self.updateUI(with: self.categories)
            }
        }
    }
    
    
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)

        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        
        cell.textLabel?.text = categoryString.capitalized
        
        guard let menuItem = menuItems.first(where: { item in
            return item.category == categoryString
        }) else { return }
        
        MenuController.shared.fetchImage(url: menuItem.imageURL) { image in
            guard let image = image else { return }
            
            DispatchQueue.main.async {
                guard let currentIndexPath = self.tableView.indexPath(for: cell) else { return }
                
                guard currentIndexPath == indexPath else { return }
                
                cell.imageView?.image = image
                
                self.fitImage(in: cell)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }

}
