//
//  DetailsViewController.swift
//  Countries
//
//  Created by Aleksandra Konopka on 09/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var nativeNameLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var callingCodeLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    
    @IBOutlet var myMap: MKMapView!
    
    var codes = ""
    
    var chosenCountry : Country?
    
    //var info : (nameLabel: String, nativeName : String, capital : String, code : String, callingCode : String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        capitalLabel.text = "Capital: \(chosenCountry!.capital)"
        nameLabel.text = "Name: \(chosenCountry!.name)"
        nativeNameLabel.text = "Native Name: \(chosenCountry!.nativeName)"
        codeLabel.text = "Code : \(chosenCountry!.alpha2Code)"
        for code in chosenCountry!.callingCodes
        {
            codes = codes + " \(code)"
        }
        callingCodeLabel.text = "Calling codes:\(codes)"
        populationLabel.text = "Population: \(chosenCountry!.population)"
        if chosenCountry!.area != nil
        {
        areaLabel.text = "Area: \(chosenCountry!.area!)"
        }
        else
        {
        areaLabel.text = "Area: - "
        }
        zoomOnRegion()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func zoomOnRegion()
    {
        if let latitude = chosenCountry?.latlng[0]
        {
            let longitude = (chosenCountry?.latlng[1])!
       //print((chosenCountry?.latlng[0])!)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        myMap.setRegion(region,animated:true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
