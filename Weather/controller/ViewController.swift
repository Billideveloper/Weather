//
//  ViewController.swift
//  Weather
//
//  Created by Ravi Thakur on 18/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

    
    @IBOutlet weak var cityname: UITextField!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    
   
    @IBOutlet weak var get_weather: UIImageView!
    
    
    
    var weather_manager = Weather_manager()
       
    var locationmanager = CLLocationManager()
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           locationmanager.delegate = self
           
           locationmanager.requestWhenInUseAuthorization()
           locationmanager.requestLocation()
           
           
           weather_manager.delegate = self
           
           cityname.delegate = self
           // Do any additional setup after loading the view.
       }
    
    
    @IBAction func current_Location_Weather(_ sender: Any) {
        
        locationmanager.requestLocation()
        
    }
    
    
    @IBAction func cityname_Location(_ sender: Any) {
        
        if let city = cityname.text{
                    
                   
            weather_manager.fetchweather(cityname: city)
                  
        }
        
    }
    
  
}

//MARK: - Text field delegate

extension ViewController: UITextFieldDelegate{
    
    
    
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          if textField.text != ""{
              return true
          }else{
              
              textField.placeholder = "type something"
              return false
              
          }
      }
      
      
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          cityname.endEditing(true)
      }
      
      func textFieldDidEndEditing(_ textField: UITextField) {
          
          
          
          if let city = cityname.text{
              
              weather_manager.fetchweather(cityname: city)
            
          }
          
      
          cityname.text = ""
      }
      
    
}

//MARK: - weather manager delegate

extension ViewController: WeathermanagerDelegate{
    
    
    func didupdateweather(_ weathermanager: Weather_manager ,weather: Weather_Model) {
        
       
//        if let imageis = UIImage(systemName: image){
//
//            DispatchQueue.main.async {
//
//                self.get_weather.image = imageis
//            }
//        }
        
     
        
        DispatchQueue.main.async {
            
            self.city.text = weather.cityName
            
            self.temp.text = "\(weather.tempstring)°C"
            
            self.get_weather.image = UIImage(systemName: weather.conditionname)
        
    
        }
        
       
        
        
       
      }
    
    func didfailwitherror(error: Error) {
           print("error")
       }
    
    
}
//MARK: - location manager delegate

extension ViewController: CLLocationManagerDelegate{
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       if let location = locations.last{
        
        locationmanager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let long = location.coordinate.longitude
    
        weather_manager.fetchweatherr(lat: lat, lon: long)
        }

        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error we got")
    }
}
