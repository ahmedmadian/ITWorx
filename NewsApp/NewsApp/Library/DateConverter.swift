//
//  DateConverter.swift
//  NewsApp
//
//  Created by Ahmed Madian on 3/5/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class DateConvertor {
    
    // MARK: Properties
    static var shared: DateConvertor = DateConvertor()
    private let dateFormatter = DateFormatter()

    //MARK: Initiliazer
    private init(){}
    
    // MARK: Converter Methods
    func stringFrom(date: Date, withFormat: DateFormat) -> String? {
        dateFormatter.dateFormat = withFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    func dateFrom(string: String, withFormat: DateFormat) -> Date? {
        dateFormatter.dateFormat = withFormat.rawValue
        return dateFormatter.date(from: string)
    }
    
    func getConverted(dateString: String, fromFormat: DateFormat, toFormat: DateFormat) -> String {
        dateFormatter.dateFormat = fromFormat.rawValue
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        dateFormatter.dateFormat = toFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    func getConverted(date: Date, fromFormat: DateFormat, toFormat: DateFormat) -> Date {
        dateFormatter.dateFormat = fromFormat.rawValue
        let dateString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = toFormat.rawValue
        guard let convertedDate = dateFormatter.date(from: dateString) else { return date }
        return convertedDate
    }
    
}

// MARK: - Date formats
public enum DateFormat: String {
    case yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ" // 2018-11-05T08:58:44+0000
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss" // 2018-11-05T08:58:44
    case EEEEMMMdyyyy = "EEEE, MMM d, yyyy" // Monday, Nov 5, 2018
    case MMddyyyy = "MM/dd/yyyy" // 11/05/2018
    case yyyyMMdd = "yyyy-MM-dd" // "1991-02-23"
    case MMddyyyyHHmm = "MM-dd-yyyy HH:mm" // 11-05-2018 08:58
    case MMMdhmma = "MMM d, h:mm a" // Nov 5, 8:58 AM
    case MMMdyyyyhmma = "MMM d, yyyy h:mm a" // Nov 8, 2018 at 3:29 PM
    case MMMMyyyy = "MMMM yyyy" // November 2018
    case ddMMMMyyyy = "dd MMMM yyyy" // November 2018
    case MMMdyyyy = "MMM d, yyyy" // Nov 5, 2018
    case EdMMMyyyyHHmmssZ = "E, d MMM yyyy HH:mm:ss Z" // Mon, 5 Nov 2018 08:58:44 +0000
    case ddMMyy = "dd.MM.yy" // 05.11.18
    case hha = "hh a" // 11 pm
    case HHmm = "HH:mm" // 17:14
    case EEEE = "EEEE" // Monday
    case EEEMMMddHHmmssZyyyy = "EEE MMM dd HH:mm:ss Z yyyy"  // Tue Mar 26 08:32:28 +0000 2019
    case hmmaMMMdyyyy = "h:mm a - MMM d yyyy" // 5:45 PM Oct. 10 2018
}
