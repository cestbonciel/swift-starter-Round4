//
//  main.swift
//  CodeStarterCamp_Week4
//
//  Created by JeonSangHyeok on 2023/03/17.
//

import Foundation

struct Activity {
    let name: String
    let action: (BodyCondition) -> Void
}

class BodyCondition {
    var upperBodyStrength: Int = 0 {
        didSet {
            print("상체근력이 \(upperBodyStrength - oldValue) 상승합니다.")
        }
    }
    var lowerBodyStrength: Int = 0 {
        didSet {
            print("하체근력이 \(lowerBodyStrength - oldValue) 상승합니다.")
        }
    }
    var muscularEndurance: Int = 0 {
        didSet {
            print("근지구력이 \(muscularEndurance - oldValue) 상승합니다.")
        }
    }
    var fatigue: Int = 0 {
        didSet {
            fatigue >= oldValue ? print("피로도가 \(fatigue - oldValue) 상승합니다.") : print("피로도가 \(fatigue - oldValue) 감소합니다.")
        }
    }
    
    func checkCondition() {
        print("""
                --------------
                현재의 컨디션은 다음과 같습니다.
                상체근력: \(self.upperBodyStrength)
                하체근력: \(self.lowerBodyStrength)
                근지구력: \(self.muscularEndurance)
                피로도: \(self.fatigue)
                --------------
                """)
    }
}

enum RoutineError: Error {
    case overLimitFatigue
    case overLimitRange
    case unexpectedInput
}

class Routine {
    var name: String
    var activities: [Activity]
    let routineCount = ["첫", "두", "세", "네", "다섯"]
    var bodyCondition = BodyCondition()
    
    init(name: String, activities: [Activity]) {
        self.name = name
        self.activities = activities
    }
    
    func startRoutine() {
        do {
            try getRouineCout()
        } catch RoutineError.overLimitRange {
            print("1에서 5까지의 숫자를 입력 바랍니다.")
        } catch RoutineError.unexpectedInput {
            print("잘못된 입력 형식입니다. 다시 입력해주세여.")
        } catch RoutineError.overLimitFatigue {
            print("피로도가 100 이상입니다. 루틴을 종료합니다.")
            print(bodyCondition.checkCondition())
        } catch {
            print("원인 모를 에러가 발생하였습니다..")
        }
    }
    
    @discardableResult
    func getRouineCout() throws -> Int {
        print("루틴을 몇 번 반복할까요?")
        guard let input = readLine(), let roundTImes = Int(input)
        else {
            throw RoutineError.unexpectedInput
        }
        guard 0 < roundTImes && roundTImes < 6
        else {
            throw RoutineError.overLimitRange
        }
        print("--------------")
        try setRoutine(roundTImes)
        return roundTImes
    }
    
    func setRoutine(_ roundTimes: Int) throws {
        for count in 0..<roundTimes {
            print("\(routineCount[count]) 번째 \(self.name)을(를) 시작합니다.")
            for activity in activities {
                activity.action(self.bodyCondition)
                print("--------------")
                if self.bodyCondition.fatigue >= 100 {
                    throw RoutineError.overLimitFatigue
                }
            }
        }
        bodyCondition.checkCondition()
    }
    
}

struct Training {
    
    let 윗몸일으키기: Activity = Activity(name: "윗몸일으키기", action: { BodyCondition in
        print("<<윗몸일으키기을(를) 시작합니다>>")
        BodyCondition.upperBodyStrength += Int.random(in: 10...20)
        BodyCondition.fatigue += Int.random(in: 10...20)
    })
    
    let 스쿼트: Activity = Activity(name: "스쿼트", action: { BodyCondition in
        print("<<스쿼트을(를) 시작합니다>>")
        BodyCondition.lowerBodyStrength += Int.random(in: 20...30)
        BodyCondition.fatigue += Int.random(in: 10...20)
    })
    
    let 오래달리기: Activity = Activity(name: "오래달리기", action: { BodyCondition in
        print("<<오래달리기을(를) 시작합니다>>")
        BodyCondition.muscularEndurance += Int.random(in: 20...30)
        BodyCondition.upperBodyStrength += Int.random(in: 5...10)
        BodyCondition.lowerBodyStrength += Int.random(in: 5...10)
        BodyCondition.fatigue += Int.random(in: 20...30)
    })
    
    let 동적휴식: Activity = Activity(name: "동적휴식", action: { BodyCondition in
        print("<<동적휴식을(를) 시작합니다>>")
        BodyCondition.fatigue -= Int.random(in: 5...10)
    })
    
    let 벤치프레스: Activity = Activity(name: "벤치프레스", action: { BodyCondition in
        print("<<벤치프레스을(를) 시작합니다>>")
        BodyCondition.upperBodyStrength += Int.random(in: 30...50)
        BodyCondition.fatigue += Int.random(in: 10...20)
    })
    
    let 레그프레스: Activity = Activity(name: "레그프레스", action: { BodyCondition in
        print("<<레그프레스을(를) 시자갑니다>>")
        BodyCondition.lowerBodyStrength += Int.random(in: 30...50)
        BodyCondition.fatigue += Int.random(in: 10...20)
    })
    
}

let trainingList = Training()

let hyeokRoutine = Routine(name: "hell", activities: [trainingList.스쿼트, trainingList.윗몸일으키기, trainingList.동적휴식])

hyeokRoutine.startRoutine()
