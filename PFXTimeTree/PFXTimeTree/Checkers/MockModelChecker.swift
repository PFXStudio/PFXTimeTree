//
//  MockModelChecker.swift
//  PFXTimeTree
//
//  Created by PFXStudio on 2019. 2. 16..
//  Copyright © 2019년 PFXStudio. All rights reserved.
//

import UIKit

class MockModelChecker: NSObject {
    func conflictMockModels(mockModels: [MockModel]) -> [Int] {
        var results = Array<Int>()
        var times = Array(repeating: 0, count: 60 * 24)
        // check conflict
        for i in 0..<mockModels.count {
            // 시작 분과 끝나는 분 값을 키 값으로 하여 배열화 함
            var mockModel = mockModels[i]
            let (totalStartMin, totalEndMin) = mockModel.totalDayMinute
            assert(totalStartMin < totalEndMin, "wrong totalEndMin")
            for x in totalStartMin...totalEndMin {
                times[x] = times[x] + 1
                
                if times[x] >= 2 {
                    // conflict
                    results.append(i) 
                }
            }
        }
        
        return results
    }
}
