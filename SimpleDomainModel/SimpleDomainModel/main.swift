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
    let namesOfIntegers : [String: Double] = ["USD": 1.0, "EUR": 1.50, "GBP": 0.50, "CAN": 1.25]
    var newAmount = Double(self.amount) * 1.0
    newAmount = newAmount / namesOfIntegers[self.currency]! * namesOfIntegers[to]!
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
        return i
    case .Hourly(let d):
        return Int(Double(d) * Double(hours))
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Salary(let i):
        self.type = JobType.Salary(i + Int(amt))
    case .Hourly(let d):
        self.type = JobType.Hourly(d + amt)
    }
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
        if (age < 16) {
            _job = nil
        } else {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
        return _spouse
    }
    set(value) {
        if (age < 18) {
            _job = nil
        } else {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    var retStr = "[Person: firstName:" + firstName + " lastName:" + lastName + " age:" + String(age) + " job:"
    retStr = retStr + String(self._job?.title ?? "nil")
    retStr = retStr + " spouse:" + String(self.spouse?.firstName ?? "nil") + "]"
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
    for i in members {
        if (i._spouse != nil) {
            if (i.age < 21 && Int(i._spouse?.age ?? 0) < 21) {
                return false
            }
        }
    }
    members.append(child)
    return true
  }
  
  open func householdIncome() -> Int {
    var total = 0
    for i in members {
        print(i.toString())
        total = total + Int(i.job?.calculateIncome(2000) ?? 0)
        print(Int(i.job?.calculateIncome(2000) ?? 0))
        print(total)
    }
    return total
  }
}
