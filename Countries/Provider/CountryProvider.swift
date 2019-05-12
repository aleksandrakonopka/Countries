//
//  CountryProvider.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import Foundation

class CountryProvider: Providing {
    
    let jsonUrlString = "https://restcountries.eu/rest/v2/all"
    
    func fetch(completion : @escaping ([Country]?,Error?) -> Void){
        let url = URL(string:jsonUrlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            do {
                guard let data = data else {return}
                let countries = try JSONDecoder().decode([Country].self, from: data)
                print(countries)
                completion(countries, nil)
            } catch let jsonErr {
                completion(nil,jsonErr)
            }
            }
        task.resume()
    }
}
