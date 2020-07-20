//
//  Weather_Model.swift
//  Weather
//
//  Created by Ravi Thakur on 19/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import Foundation


struct Weather_Model {
    
    let conditionId: Int
    
    let cityName: String
    
    let temp: Double
    
    
    var tempstring: String{
        
        return String(format: "%.1f", temp)
    }
    
    var conditionname:String{
        
        switch conditionId {
                  
              case 200...232:
                 
                  return "cloud.bolt"
                  
              case 300...321:
                  
                  return "cloud.drizzle"
              
              case 500...531:
                         
                  return "cloud.rain"
                  
              case 600...622:
                     
                  return "cloud.snow"
                  
              case 701...781:
                         
                  return "cloud.fog"
                  
              case 800:
                  
                   return "sun.max"
                  
              case 801...804:
                  
                  return "cloud.bolt"
              
              default:
                  return "cloud"
              }
        
    }
    
    
}
