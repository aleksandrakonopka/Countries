//
//  ViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var countryProvider = CountryProvider()
    var countries = [Country]()
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countries.count > 0
        {
        return(countries.count)
        }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
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
                            self.tableView.reloadData()
                        }
                    }
            }
        })
            
       }
    }


}

