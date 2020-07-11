//
//  DateFromatter.swift
//  PreggNet
//
//  Created by ADF on 11/8/19.
//  Copyright © 2019 ADF. All rights reserved.
//

import Foundation


class MyDateFormatter{
    func getDateString(date: Date) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE MMM d, yyyy"
        return dateformatter.string(from: date)
    }
}

