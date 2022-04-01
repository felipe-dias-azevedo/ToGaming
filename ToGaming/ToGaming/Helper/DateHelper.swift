//
//  DateHelper.swift
//  ToGaming
//
//  Created by felipe azevedo on 19/03/22.
//

import Foundation

class DateHelper {
    
    static func toString(_ date: Date) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        return dateFormatter.string(from: date)
    }
    
    static func toInterval(from dateCount: Int) -> Date {
        
        let time = 86400 * dateCount
        
        let interval = TimeInterval(time)
        
        return Date.now.addingTimeInterval(-interval)
    }
}
