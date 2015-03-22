//
//  Utils.swift
//  iShotsApp
//
//  Created by yuye wang on 3/21/15.
//  Copyright (c) 2015 yuye wang. All rights reserved.
//

import Foundation


class Utils {
    class func getStringFromJSON(data: NSDictionary, key: String) -> String{
        
        if let info = data[key] as? String {
            return info
        }
        return ""
    }
}
