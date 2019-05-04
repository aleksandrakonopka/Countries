//
//  ViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

struct Country : Decodable
{
    var name: String
    var topLevelDomain : [String]
    var alpha2Code : String
    var alpha3Code : String
    var callingCodes : [String]
    var capital : String
    var altSpellings : [String]
    var region : String
    var subregion : String
    var population : Int
    var latlng : [Float]
    var demonym : String
    var area : Double? = 0
 //  var gini : Double
    var timezones : [String]
    var borders : [String]
    var nativeName : String
    //var numericCode : String
    //var currencies
    //var languages
    //var translations : [String: String]
    var flag : String
    //var regionBlocs
    //var cioc : String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Zaczynamy!")
        let jsonUrlString = "https://restcountries.eu/rest/v2/all"
        let url = URL(string:jsonUrlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            do {
                //print("weszlo")
                guard let data = data else {return}
                let countries = try JSONDecoder().decode([Country].self, from: data)
                print(countries)
            } catch let jsonErr {
                print("Error serializing json:",jsonErr)
            }
        }.resume()
        
    }


}

