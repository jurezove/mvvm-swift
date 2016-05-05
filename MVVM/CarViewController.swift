//
//  CarViewController.swift
//  MVVM
//
//  Created by Jure Zove on 04/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CarViewController: UIViewController {

  var carViewModel: CarViewModel?
  
  @IBOutlet weak var makeField: UITextField!
  @IBOutlet weak var modelField: UITextField!
  @IBOutlet weak var kilowattField: UITextField!
  
  @IBOutlet var saveButton: UIBarButtonItem!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let carViewModel = carViewModel else {
      return
    }
    
    carViewModel.makeText.bindTo(makeField.rx_text).addDisposableTo(disposeBag)
    carViewModel.modelText.bindTo(modelField.rx_text).addDisposableTo(disposeBag)
    carViewModel.kilowattText.map({ (kw) -> String in
      return "\(kw)"
    }).bindTo(kilowattField.rx_text).addDisposableTo(disposeBag)
    
    makeField.rx_text.bindTo(carViewModel.makeText).addDisposableTo(disposeBag)
    modelField.rx_text.bindTo(carViewModel.modelText).addDisposableTo(disposeBag)
    kilowattField.rx_text.filter({ (string) -> Bool in
      // Validate we are only passing Ints
      return Int(string) != nil
    }).bindTo(carViewModel.kilowattText).addDisposableTo(disposeBag)
    
    carViewModel.titleText.subscribeNext { (title) in
      self.navigationItem.title = title
    }.addDisposableTo(disposeBag)
    
    navigationItem.rightBarButtonItem = saveButton
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func save(sender: AnyObject) {
    navigationController?.popViewControllerAnimated(true)
  }
}
