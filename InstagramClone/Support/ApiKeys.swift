//
//  ApiKeys.swift
//  InstagramClone
//
//  Created by ngt kn on 7/23/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
