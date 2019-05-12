//
//  ViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
class ViewController: UIViewController{
    var isIndicatorVisible = true
    @IBOutlet var cancelButton: UIButton!
    var chosenCountry : Country?
    @IBOutlet var searchBar: UISearchBar!
    var countryProvider = CountryProvider()
    var countries = [Country]()
    var searchCountries = [Country] ()
    @IBOutlet var tableView: UITableView!
    var searching = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"
        {
            let destinationVC = segue.destination as! DetailsViewController
                destinationVC.chosenCountry = chosenCountry
        }
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        view.endEditing(true)
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showCountries()
        self.hideKeyboardWhenSwipeAround()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       view.endEditing(true)
    }
    
    @objc func showCountries(){
        Dispatch.DispatchQueue.global(qos: .utility).async {
            self.countryProvider.fetch(completion: { (countriesGet, errorGet) in
                if let countriesGot = countriesGet{
                    if errorGet == nil || countriesGot.count > 1{
                        self.countries = countriesGot
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                            self.tableView.isHidden = false
                        }
                    }
                }
                else
                {
                    if errorGet != nil || countriesGet == nil
                    {
                        self.addAlert()
                    }
                }
        })
       }
    }
    func addAlert()
    {
        let alert = UIAlertController(title: "Cant load data", message: "Try again later", preferredStyle: .alert )
        let ok = UIAlertAction(title: "OK", style: .default){ action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        self.present(alert,animated: true, completion: nil)
    }
}


extension ViewController : UISearchBarDelegate{

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCountries = countries.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
}

extension UIViewController {
    func hideKeyboardWhenSwipeAround() {
        let swipe: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        swipe.cancelsTouchesInView = false
        view.addGestureRecognizer(swipe)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching
        {
            return(searchCountries.count)
        } else
        {  return(countries.count) }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
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
}
