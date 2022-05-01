//
//  NSDateFormatterExtension .swift
//  myHabits
//
//  Created by Табункин Вадим on 25.04.2022.
//

import Foundation

extension DateFormatter {

    static func friendlyStringForDate(date: Date) -> String {
        // Fetch the default calendar
        let calendar = Calendar.current
        let unitFlags: NSCalendar.Unit = [.day]
        
        // Compute days difference between the two
        let delta = (calendar as NSCalendar).components(unitFlags, from: date, to: Date(), options: [])

        if let day = delta.day {

            switch day {
            case 0:
                let formatter = DateFormatter()
                formatter.timeZone = NSTimeZone.default
                formatter.dateFormat = "Сегодня"
                return formatter.string(from: date)

            case 1:
                return "Вчера"

            case 2:
                return "Позавчера"

            default:
                let formatter = DateFormatter()
                formatter.timeStyle = .none
                formatter.dateFormat = "d MMMM YYYY"
                return formatter.string(from: date)
            }
        }
        return ""
    }
}
