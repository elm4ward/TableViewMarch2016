//
//  TableViewController.swift
//  TableViewMarch2016
//
//  Created by dasdom on 28.03.16.
//  Copyright © 2016 dasdom. All rights reserved.
//

import UIKit


protocol BaseTableViewController {
  
  associatedtype CellType: UITableViewCell, Configurable
  associatedtype ModelType

  var tableView: UITableView! { get }
  
  var data: [ModelType] { get set }
  
}

extension BaseTableViewController where Self: UITableViewController {
  
  func setupTableView() {
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60
    tableView.registerClass(CellType.self, forCellReuseIdentifier: "cell")
  }

  func configuredCell(forIndexPath indexPath: NSIndexPath) -> CellType {
    let cell =  tableView.dequeueReusableCellWithIdentifier("cell",
                                                forIndexPath: indexPath) as! CellType
    cell.config(withItem: data[indexPath.row])
    return cell
  }
  
  func reloadTableView() {
    tableView.reloadData()
    if tableView.numberOfRowsInSection(0) > 0 {
      tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0,inSection: 0),
                                       atScrollPosition: .Top,
                                       animated: true)
    }
  }
  
}