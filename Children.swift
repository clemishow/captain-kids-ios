//
//  Children.swift
//  captain kids
//
//  Created by Dev on 19/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import Foundation

class Children {
    
    var name: String?
    var lat: Double?
    var lng: Double?
    var male: Bool?
    var city: String?
    
    init(name: String?, lat: Double?, lng: Double?, male: Bool?, city: String?) {
        self.name = name
        self.lat = lat
        self.lng = lng
        self.male = male
        self.city = city
    }
    
}
