//
//  TableViewController.swift
//  MVVM
//
//  Created by Jure Zove on 01/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  let cars: [CarViewModel] = (UIApplication.sharedApplication().delegate as! AppDelegate).cars
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cars.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("CarCell", forIndexPath: indexPath)
    let carViewModel = cars[indexPath.row]
    
    cell.textLabel?.text = carViewModel.titleText
    cell.detailTextLabel?.text = carViewModel.horsepowerText
    loadImage(cell, photoURL: carViewModel.photoURL)
    
    return cell
  }
  
  func loadImage(cell: UITableViewCell, photoURL: NSURL?) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      guard let imageURL = photoURL, imageData = NSData(contentsOfURL: imageURL) else {
        return
      }
      dispatch_async(dispatch_get_main_queue()) {
        cell.imageView?.image = UIImage(data: imageData)
        cell.setNeedsLayout()
      }
    }
  }
  
}
