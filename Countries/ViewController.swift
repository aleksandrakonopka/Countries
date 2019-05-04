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
    //var topLevelDomain
    //var alpha2Code
    //var alpha3Code
    //var callingCodes : [Int]
    var capital : String
    //var altSpellings
    var region : String
    //var subregion
    var population : Int
    var latlng : [Float]
    //var demonym
    //var area
    //var gini
    //var timezones
    //var borders
    var nativeName: String
    //var numericCode
    //var currencies
    //var languages
    //var translations
    //var flag
    //var regionBlocs
    //var cioc
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonUrlString = "https://restcountries.eu/rest/v2/all"
        let url = URL(string:jsonUrlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            do {
                guard let data = data else {return}
                let countries = try JSONDecoder().decode([Country].self, from: data)
                print(countries)
            } catch let jsonErr {
                print("Error serializing json:",jsonErr)
            }
        }.resume()
        
    }


}

