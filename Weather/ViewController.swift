//
//  ViewController.swift
//  Weather
//
//  Created by Ravi Thakur on 18/07/20.
//  Copyright © 2020 billidevelopers. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{

    
    
    @IBOutlet weak var cityname: UITextField!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    var manager = Weather_manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

}

