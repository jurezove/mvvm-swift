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
  @IBOutlet weak var horsepowerField: UITextField!
  
  @IBOutlet var saveButton: UIBarButtonItem!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let carViewModel = carViewModel else {
      return
    }
    
    carViewModel.makeText.bindTo(makeField.rx_text).addDisposableTo(disposeBag)
    carViewModel.modelText.bindTo(modelField.rx_text).addDisposableTo(disposeBag)
    carViewModel.horsepowerText.bindTo(horsepowerField.rx_text).addDisposableTo(disposeBag)
    
    makeField.rx_text.subscribeNext { (make) in
      carViewModel.makeText.onNext(make)
    }.addDisposableTo(disposeBag)
    
    modelField.rx_text.subscribeNext { (model) in
      carViewModel.modelText.onNext(model)
    }.addDisposableTo(disposeBag)
    
    horsepowerField.rx_text.subscribeNext { (horsepower) in
      carViewModel.horsepowerText.onNext(horsepower)
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
