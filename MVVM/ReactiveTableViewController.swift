//
//  ReactiveTableViewController.swift
//  MVVM
//
//  Created by Jure Zove on 04/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import UIKit
import RxSwift

class ReactiveTableViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var cars: Variable<[CarViewModel]> = Variable((UIApplication.sharedApplication().delegate as! AppDelegate).cars)
  let disposeBag = DisposeBag()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 80
    tableView.rowHeight = UITableViewAutomaticDimension
    
    cars.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier("CarCell", cellType: CarTableViewCell.self)) { (index, carViewModel: CarViewModel, cell) in
      cell.carViewModel = carViewModel
    }.addDisposableTo(disposeBag)
    
    tableView.rx_itemSelected.subscribeNext { (indexPath) in
      self.performSegueWithIdentifier("showReceipt", sender: indexPath)
      self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }.addDisposableTo(disposeBag)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let indexPath = sender as? NSIndexPath, carVC = segue.destinationViewController as? CarViewController else {
      return
    }
    carVC.carViewModel = cars.value[indexPath.row]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
