//
//  ViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var searchBar: UISearchBar!
    var countryProvider = CountryProvider()
    var countries = [Country]()
    var searchCountries = [Country] ()
    @IBOutlet var tableView: UITableView!
    var searching = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return(searchCountries.count)
        } else
        {  return(countries.count) }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        if searching == true
        {
           cell.textLabel?.text = searchCountries[indexPath.row].name
        }
        else
        {
        cell.textLabel?.text = countries[indexPath.row].name
        }
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


extension ViewController : UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCountries = countries.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
