//
//  weather_Manager.swift
//  Weather
//
//  Created by Ravi Thakur on 19/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import Foundation

struct Weather_manager {
    
    
    let url = "api.openweathermap.org/data/2.5/weather?q={city name}&appid=509ee3a0bd89402c21dd5dc525a8ac01"
    
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
            
            print(error?.localizedDescription as Any)
            return
        }
        
        if let mydata = data{
            
           // let stringdata = String(data: mydata, encoding: .utf8)
            
            parsedata(weatherdata: mydata)
          
            
        }
    
    }
    
    
    
    func parsedata(weatherdata:Data){
        
        let decoder = JSONDecoder()
        do{
        
        let decoded_data = try decoder.decode(Weather_data.self, from: weatherdata)
            
           
            let temp = decoded_data.main.temp
            
            let id = decoded_data.weather[0].id
            
            let name = decoded_data.name
            
            let weather = Weather_Model(conditionId: id, cityName: name, temp: temp)
            
            //getconditionname(weatherId: id)
            
            print(weather.tempstring)
            
            print(weather.conditionname)
            
            
        }catch{
            
            print(error)
        }
        
    }
    
}
