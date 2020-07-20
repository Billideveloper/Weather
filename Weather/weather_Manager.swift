//
//  weather_Manager.swift
//  Weather
//
//  Created by Ravi Thakur on 19/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeathermanagerDelegate {
    func didupdateweather(_ weathermanager: Weather_manager ,weather: Weather_Model)
    
    func didfailwitherror(error:Error)
}

struct Weather_manager {
    
    var delegate: WeathermanagerDelegate?
    
    let url = "api.openweathermap.org/data/2.5/weather?q={city name}&appid=509ee3a0bd89402c21dd5dc525a8ac01"
    
    let urlgeo = "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}"
    
    
    func fetchweatherr(lat: CLLocationDegrees, lon: CLLocationDegrees){
        
        let urlcor = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=509ee3a0bd89402c21dd5dc525a8ac01"
        
        getweather(myurl: urlcor)
    }
    
    
    
    func fetchweather(cityname:String){
        
        let urlstring = "https://api.openweathermap.org/data/2.5/weather?q=\(cityname)&appid=509ee3a0bd89402c21dd5dc525a8ac01"
        
    
        //https://api.openweathermap.org/data/2.5/weather?q=Indore&appid=509ee3a0bd89402c21dd5dc525a8ac01
        
        getweather(myurl: urlstring)
        
    }
    
    
    func getweather(myurl:String){
        
        
        // create a url

        if let urls = URL(string: myurl){
            
            // create a URLsession
            
            let session = URLSession(configuration: .default)
            
            // create a session task
            
            let task =  session.dataTask(with: urls, completionHandler: handle(data:response:error:))
             
            //start the task
            
            task.resume()
        }
    }
    
    
    func handle(data: Data?, response: URLResponse?, error:Error?){
        
        if error != nil{
            
            self.delegate?.didfailwitherror(error: error!)
            return
        }
        
        if let mydata = data{
            
           // let stringdata = String(data: mydata, encoding: .utf8)
            
            if  let weather =   self.parsedata(weatherdata: mydata){
                
                
                
                self.delegate?.didupdateweather(self, weather:weather)
                
            }
          
            
        }
    
    }
    
    
    
    func parsedata(weatherdata:Data) -> Weather_Model?{
        
        let decoder = JSONDecoder()
        do{
        
        let decoded_data = try decoder.decode(Weather_data.self, from: weatherdata)
            
           
            let temp = decoded_data.main.temp
            
            let id = decoded_data.weather[0].id
            
            let name = decoded_data.name
            
            let weather = Weather_Model(conditionId: id, cityName: name, temp: temp)
            
            //getconditionname(weatherId: id)
            return weather
         
        }catch{
            
            self.delegate?.didfailwitherror(error: error)
            
            return nil
            
        }
        
    }
    
}
