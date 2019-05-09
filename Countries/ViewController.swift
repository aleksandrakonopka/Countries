//
//  ViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var chosenCountry : Country?
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"
        {
            let destinationVC = segue.destination as! DetailsViewController
                destinationVC.chosenCountry = chosenCountry
            
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching == true
        {
            chosenCountry = searchCountries[indexPath.row]
        }
        else
        {
            chosenCountry = countries[indexPath.row]
        }
        performSegue(withIdentifier: "showDetails", sender: self)
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
