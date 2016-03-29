//
//  RepositoriesTableViewController.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController, BaseTableViewController {

  typealias CellType = TwoLabelCell

  var data = [Repository]() {
    didSet {
      reloadTableView()
    }
  }
  
  var username: String? {
    didSet {
      guard let username = username where username.characters.count > 0 else { return }
      let fetch = APIClient<Repository>().fetchItems(forUser: username)
      fetch { (items, error) -> Void in
        self.title = username
        guard let theItems = items else { return }
        self.data = theItems.map { $0 }
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return configuredCell(forIndexPath: indexPath)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let nextViewController = DetailViewController()
    nextViewController.repository = data[indexPath.row]
    navigationController?.pushViewController(nextViewController, animated: true)
  }

}
