//
//  DeadlineManager.swift
//  Hatnya
//
//  Created by kelly on 2022/08/01.
//

import Foundation

final class DeadlineManager {
    let dayOfWeekNum = ["월": 0, "화": 1, "수": 2, "목": 3, "금": 4, "토": 5, "일": 6]
    
    func getOffsetToDeadline(appStartDate: Date, cycle: Int, cycleDay: [String]) -> Int {
        let studyStartDate = getStudyStartDate(appStartDate: appStartDate, cycleDay: cycleDay)
        var offsetToDeadline: Int = 0
        
        if studyStartDate < Date() {
            offsetToDeadline = getClosestCycleOffset(cycle: cycleDay, startDay: Date())
            let nearestCycleDate = Date(timeIntervalSinceNow: 60 * 60 * 24 * Double(offsetToDeadline))
            
            let dateComponent = Calendar.current.dateComponents([.day], from: studyStartDate, to: nearestCycleDate)
            guard let offsetDay = dateComponent.day else { return 0 }
            let offsetWeek = offsetDay / 7
            
            if !offsetWeek.isMultiple(of: cycle) {
                offsetToDeadline += 7 * (cycle - (offsetWeek % cycle))
            }
            offsetToDeadline -= (dayOfWeekNum[nearestCycleDate.getDayOfWeek]! - dayOfWeekNum[cycleDay[0]]!)
        } else {
            let dateComponent = Calendar.current.dateComponents([.day], from: Date(), to: studyStartDate)
            guard let offset = dateComponent.day else { return 0 }
            offsetToDeadline = offset
        }
        
        return offsetToDeadline
    }

    private func getStudyStartDate(appStartDate: Date, cycleDay: [String]) -> Date {
        let offset = getClosestCycleOffset(cycle: [cycleDay[0]], startDay: appStartDate)
        let studyStartDate = Date(timeInterval: 60 * 60 * 24 * Double(offset), since: appStartDate)
        
        return studyStartDate
    }

    private func getClosestCycleOffset(cycle: [String], startDay: Date) -> Int {
        let startDayOfWeek = startDay.getDayOfWeek
        var offset = -1
        
        for day in cycle {
            if dayOfWeekNum[day]! >= dayOfWeekNum[startDayOfWeek]! {
                offset = dayOfWeekNum[day]! - dayOfWeekNum[startDayOfWeek]!
                break
            }
        }
        if offset == -1 {
            offset = 7 - (dayOfWeekNum[startDayOfWeek]! - dayOfWeekNum[cycle[0]]!)
        }
        
        return offset
    }
}
