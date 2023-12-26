//
//  main.swift
//  CodeStarterCamp_Week4
//
//  Created by Nat Kim on 2023/12/22.
//

import Foundation

//print("입력하세요: \(readLine())")
//if let input: String = readLine() {
//    print("입력값은 \(String(describing: input))입니다.")
//}
//

print("입력해주세요 :", terminator: "")
if let input = readLine() {
    print("입력값은 \(input)입니다")
}


while true {
    print("입력해주세요 :", terminator: "")

    if let input = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
        if input.lowercased() == "x" {
            print("종료합니다")
            break
        } else if !input.isEmpty {
            print("입력값은 \(input)입니다")
        }
    }
}

