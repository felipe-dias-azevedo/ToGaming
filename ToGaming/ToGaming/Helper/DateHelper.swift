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
    
    static func toInterval(from dayCount: Int) -> Date {
        
        let time = 86400 * dayCount
        
        let interval = TimeInterval(time)
        
        return Date.now.addingTimeInterval(-interval)
    }
    
    static func toDate(from timestamp: Int?) -> Date? {
        
        guard let time = timestamp else {
            return nil
        }
        
        return Date(timeIntervalSince1970: TimeInterval(time))
    }
    
    static func isNear(from oldDate: Date, to newDate: Date, between minutes: Int) -> Bool {
        
        let time = 3600 * minutes
        
        let interval = TimeInterval(time)
        
        return oldDate <= newDate.addingTimeInterval(interval) && newDate.addingTimeInterval(-interval) <= oldDate
    }
}
