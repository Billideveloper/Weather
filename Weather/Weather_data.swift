//
//  Weather_data.swift
//  Weather
//
//  Created by Ravi Thakur on 19/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import Foundation
struct Weather_data: Codable{
    
    let name: String
    
    let main: Main
    
    let weather: [Weather]
    
}

struct Main: Codable {
    
    let temp: Double
}

struct Weather:Codable {
    
    let id:Int
}
