//
//  ViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    var countryProvider = CountryProvider()
    var countries = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        showCountries()
    }
    
    @objc func showCountries(){
        print("jajko")
        Dispatch.DispatchQueue.global(qos: .utility).async {
            self.countryProvider.fetch(completion: { (countriesGet, errorGet) in
                print(countriesGet)
                if let countriesGot = countriesGet{
                    if errorGet == nil || countriesGot.count > 1{
                        self.countries = countriesGot
                        print("SELF COUNTRIES \(self.countries)")
                        DispatchQueue.main.async{
                            //reloadTable
                        }
                    }
            }
        })
            
       }
    }


}

