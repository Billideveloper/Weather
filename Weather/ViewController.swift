//
//  ViewController.swift
//  Weather
//
//  Created by Ravi Thakur on 18/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,WeathermanagerDelegate{

    
    @IBOutlet weak var cityname: UITextField!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    var manager = Weather_manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        cityname.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var get_weather: UIImageView!
    
    
    
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
            
            manager.fetchweather(cityname: city)
        }
        
    
        cityname.text = ""
    }
    

    func didupdateweather(_ weathermanager: Weather_manager ,weather: Weather_Model) {
        
        
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

