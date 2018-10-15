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
    self.type = type
    self.title = title
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Salary(let i):
        return Int(i / 2000) * hours
    case .Hourly(let d):
        return Int(d) * hours
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Salary(let i):
        self.type = JobType.Hourly(Double(i) * amt)
    case .Hourly(let d):
        self.type = JobType.Hourly(d * amt)
  }
}


////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {
        return _job
    }
    set(value) {
        _job = value
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
        //return Person(firstName: String(self.spouse?.firstName ?? ""), lastName: String(self.spouse?.lastName ?? ""), age: Int(self.spouse?.age ?? 0))
        return _spouse
    }
    set(value) {
        _spouse = value
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    var retStr = "[Person: firstName: " + firstName + " lastName: "
    retStr = retStr + lastName
    retStr = retStr + " age: " + String(age)
    retStr = retStr + " job: "
    retStr = retStr + "spouse: " + String(self.spouse?.firstName ?? "")
    // [Person: firstName: Ted lastName: Neward age: 45 job: Salary(1000) spouse: Charlotte]
    return retStr
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    spouse1.spouse = spouse2
    spouse2.spouse = spouse1
    members.append(spouse1)
    members.append(spouse2)
    
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}





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
