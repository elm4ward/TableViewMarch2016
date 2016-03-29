//
//  UserSearchTableViewController.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController, BaseTableViewController, UISearchBarDelegate {

  typealias CellType = TwoLabelCell

  var data = [User]() {
    didSet {
      reloadTableView()
    }
  }
  
  var searchString: String? {
    didSet {
      guard let searchString = searchString where searchString.characters.count > 0 else { return }
      let fetch = APIClient<User>().fetchUsers(forSearchString: searchString)
      fetch { (items, error) -> Void in
        guard let theItems = items else { return }
        self.data = theItems.map { $0 }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    title = "User"
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
    searchBar.placeholder = "Github username"
    searchBar.delegate = self
    tableView.tableHeaderView = searchBar
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchString = searchBar.text
  }
  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return configuredCell(forIndexPath: indexPath)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let user = self.data[indexPath.row]
    let next = RepositoriesTableViewController()
    next.username = user.name
    navigationController?.pushViewController(next, animated: true)
  }

}
