//
//  Car.swift
//  MVVM
//
//  Created by Jure Zove on 01/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Car {
  var model: String
  var make: String
  var kilowatts: Int
  var photoURL: String
  
  init(model: String, make: String, kilowatts: Int, photoURL: String) {
    self.model = model
    self.make = make
    self.kilowatts = kilowatts
    self.photoURL = photoURL
  }
}

class CarViewModel {
  let car: Car
  static let horsepowerPerKilowatt = 1.34102209
  let disposeBag = DisposeBag()
  
  var modelText: BehaviorSubject<String>
  var makeText: BehaviorSubject<String>
  var horsepowerText: BehaviorSubject<String>
  
  var titleText: BehaviorSubject<String>
  
  var photoURL: NSURL? {
    return NSURL(string: car.photoURL)
  }
  
  init(car: Car) {
    self.car = car
    modelText = BehaviorSubject<String>(value: car.model)
    modelText.subscribeNext { (model) in
      car.model = model
    }.addDisposableTo(disposeBag)
    
    makeText = BehaviorSubject<String>(value: car.make)
    makeText.subscribeNext { (make) in
      car.make = make
    }.addDisposableTo(disposeBag)
    
    
    let horsepower = Int(round(Double(car.kilowatts) * CarViewModel.horsepowerPerKilowatt))
    horsepowerText = BehaviorSubject<String>(value: "\(horsepower) HP")
    
    horsepowerText.subscribeNext { (horsepower) in
      guard let hpDouble = Double(horsepower) else {
        return
      }
      car.kilowatts = Int(round(hpDouble / CarViewModel.horsepowerPerKilowatt))
    }.addDisposableTo(disposeBag)
    
    titleText = BehaviorSubject<String>(value: "\(car.make) \(car.model)")
    [makeText, modelText].combineLatest { (carInfo) -> String in
      return "\(carInfo[0]) \(carInfo[1])"
    }.bindTo(titleText).addDisposableTo(disposeBag)
    
  }
}
