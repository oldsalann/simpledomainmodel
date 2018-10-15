//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
    
  public func convert(_ to: String) -> Money {
    let namesOfIntegers : [String: Double] = ["USD": 1.0, "EUR":2.0, "GBP": 1.50, "CAN": 0.50]
    var newAmount = Double(self.amount) * 1.0
    newAmount = newAmount / namesOfIntegers[self.currency]! / namesOfIntegers[to]!
    let finAmount : Int = Int(newAmount)
    let newMoney = Money(amount: finAmount, currency: to)
    return newMoney
  }
  
  public func add(_ to: Money) -> Money {
    let changedMoney = self.convert(to.currency)
    let newMoney = Money(amount: (changedMoney.amount + to.amount),currency: to.currency)
    return newMoney
  }
    
  public func subtract(_ from: Money) -> Money {
    let changedMoney = self.convert(from.currency)
    let newMoney = Money(amount: (from.amount - changedMoney.amount),currency: from.currency)
    return newMoney
  }
}


////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    
  }
  
  open func raise(_ amt : Double) {
  }
}
/*
////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}

*/




/*
 switch to {
 case "EUR":
 newCur = "EUR"
 newAmount = newAmount / namesOfIntegers[self.currency]! / namesOfIntegers[to]!
 case "USD":
 newCur = "USD"
 
 case "CAN":
 newCur = "CAN"
 
 case "GBP":
 newCur = "GBP"
 
 default:
 break
 }
 let finAmount : Int = Int(newAmount)
 return Money(amount: finAmount
*/
