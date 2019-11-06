//
//  Utils.swift
//  Hadi Movie
//
//  Created by Kasım on 6.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class Utils {

    static func getPosterPath(_ poster: String)-> String{
        return NetworkManager.posterBaseURL+poster
    }
    
    static func changeMoviedbDateStringFormat(_ dateString: String)-> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM yyyy"

        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            print("FIX--There was an error decoding the string")
            return ""
        }
    }
}
