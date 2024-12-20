//
//  Date+.swift
//  habitApp
//
//  Created by RikutoSato on 2024/10/30.
//

import Foundation

extension Date {
    // 日本時間に修正
    var zeroclock: Date {
        return fixed(hour: 9, minute: 0, second: 0)
    }
    
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .japan
        calendar.locale   = .japan
        return calendar
    }
    
    func fixed(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date {
        let calendar = self.calendar
        
        var comp = DateComponents()
        comp.year   = year   ?? calendar.component(.year,   from: self)
        comp.month  = month  ?? calendar.component(.month,  from: self)
        comp.day    = day    ?? calendar.component(.day,    from: self)
        comp.hour   = hour   ?? calendar.component(.hour,   from: self)
        comp.minute = minute ?? calendar.component(.minute, from: self)
        comp.second = second ?? calendar.component(.second, from: self)
        
        return calendar.date(from: comp)!
    }
}
