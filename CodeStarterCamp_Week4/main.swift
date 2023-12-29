//
//  main.swift
//  CodeStarterCamp_Week4
//
//  Created by Nat Kim on 2023/12/27.
//

import Foundation

enum VendingMachineError: Error {
    case invalidInput
    case insufficientFunds(moneyNeeded: Int)
    case outOfStock
}

class VendingMachine {
    let itemPrice: Int = 100
    private var itemStock: Int = 10
    private var coinsDeposited: Int = 0
    
    // Computed Property
    var isOutOfStock: Bool {
        return itemStock < 1
    }
    
    var price: Int {
        return 100
    }
    // 돈 받기 메서드
    func receiveMoney(_ money: Int) throws {
        // 입력한 돈이 0 이하면 오류를 던진다.
        guard money > 0 else {
            throw VendingMachineError.invalidInput
        }
        
        // 오류가 없으면 정상처리
        self.coinsDeposited += money
        print("\(money)원 받음.")
    }
    
    func insertCoin(amount: Int) {
        coinsDeposited += amount
    }
    // MARK: - 함수에서 발생한 오류 던지기
    /// 자판기 동작 도중 발생한 오류 던지기
    /// 오류 발생 여지가 있는 메서드는 throws를 사용하여
    /// 오류를 내포하는 함수임을 표시
    func vend(numberOfItems numberOfItemsToVend: Int) throws -> String {
        // 원하는 아이템의 수량이 잘못 입력되었으면 오류를 던짐
        guard numberOfItemsToVend > 0 else {
            throw VendingMachineError.invalidInput
        }
        
        // 구매하려는 수량보다 미리 넣어둔 돈이 적으면 오류를 던짐
        guard numberOfItemsToVend * itemPrice <= coinsDeposited else {
            let moneyNeeded: Int
            moneyNeeded = numberOfItemsToVend * itemPrice - coinsDeposited
            
            throw VendingMachineError.insufficientFunds(moneyNeeded: moneyNeeded)
        }
        
        // 구매하려는 수량보다 요구하는 수량이 많으면 오류를 던짐
        guard itemStock >= numberOfItemsToVend else {
            throw VendingMachineError.outOfStock
        }
        
        // 오류가 없으면 정상처리를 함
        let totalPrice = numberOfItemsToVend * itemPrice
        
        self.coinsDeposited -= totalPrice
        self.itemStock -= numberOfItemsToVend
        
        return "\(numberOfItemsToVend)개 제공함"
        
    }
    /*func vend(amount: Int = 1) throws -> String {
        guard isOutOfStock == false else {
            throw VendingMachineError.outOfStock
        }
        
        guard coinsDeposited >= price * amount else {
            throw VendingMachineError.insufficientFunds(moneyNeeded: 100)
        }
        
        coinsDeposited = coinsDeposited - (amount * price)
        
        return "상품"
    }
    */
}


func orderSoda(amount: Int = 1, machine: VendingMachine) throws {
    do {
        let item: String = try machine.vend(numberOfItems: amount)
        print("\(item) 받았음")
    } catch VendingMachineError.insufficientFunds {
        print("돈 모자람")
    } catch VendingMachineError.outOfStock {
        print("재고 부족")
    } catch {
        
    }
    
    
}

let machine: VendingMachine = VendingMachine()
var result: String?
// MARK: - 오류처리
/// 오류발생의 여지가 있는 throws 함수(메서드)는
/// try 를 사용하여 호출해야함
/// try, try?, try!

// MARK: - do-catch
/// 오류발생의 여지가 있는 throws 함수(메서드)는
/// do-catch 구문을 활용하여
/// 오류발생에 대비한다.

/*
try machine.receiveMoney(400)
try orderSoda(amount: 3, machine: machine)

*/

do {
    try machine.receiveMoney(0)
} catch VendingMachineError.invalidInput {
    print("입력이 잘못되었습니다.")
} catch VendingMachineError.insufficientFunds(let moneyNeeded) {
    print("\(moneyNeeded)원이 부족합니다.")
} catch VendingMachineError.outOfStock {
    print("수량이 부족합니다.")
}

do {
    try machine.receiveMoney(1000)
} catch /*(let error)*/ {
    switch error { // 자동으로 넘어오는 전달인자명 error
    case VendingMachineError.invalidInput:
        print("입력이 잘못되었습니다.")
    case VendingMachineError.insufficientFunds(let moneyNeeded):
        print("\(moneyNeeded)원이 부족합니다.")
    case VendingMachineError.outOfStock:
        print("수량이 부족합니다.")
    default:
        print("알 수 없는 오류: \(error)")
    }
}

do {
    result = try machine.vend(numberOfItems: 4)
} catch {
    print(error)
}

do {
    result = try machine.vend(numberOfItems: 4)
}

// MARK: - try? 와 try!
/// try?
/// 별도의 오류처리 결과를 통보받지 않고
/// 오류가 발생했으면 결괏값을 nil 로 돌려받을 수 있음
/// 정상동작 후에는 옵셔널 타입으로 정상 반환값을 돌려받는다.
result = try? machine.vend(numberOfItems: 1)
result

result = try? machine.vend(numberOfItems: 1)
result

/// try!
/// 오류가 발생하지 않을 것이라는 강력한 확신을 가질 때
/// try! 를 사용하면 정상동작 후에 바로 결과값을 돌려받음
/// 오류가 발생하면 런타임 오류가 발생하여
/// 애플리케이션 동작이 중지됨

result = try! machine.vend(numberOfItems: 1)
/*
 Thread 1: Fatal error: 'try!' expression unexpectedly raised an error: CodeStarterCamp_Week4.VendingMachineError.insufficientFunds(moneyNeeded: 100)
*/
