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
    @IBOutlet var backButton: UIButton!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoLabels()
        zoomOnRegion()
        addAnnotation()
        setBackButton()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setInfoLabels()
    {
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
    }
    func setBackButton()
    {
        backButton.layer.cornerRadius = 10
    }
    func addAnnotation()
    {
        if let latitude = chosenCountry?.latlng[0]
        {
        let longitude = (chosenCountry?.latlng[1])!
        let myAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(Double(latitude), Double(longitude))
        myAnnotation.title = chosenCountry!.name
        myAnnotation.subtitle = "Capital: \(chosenCountry!.capital)"
        self.myMap.addAnnotation(myAnnotation)
        }
    }
    func zoomOnRegion()
    {
        if let latitude = chosenCountry?.latlng[0]
        {
            let longitude = (chosenCountry?.latlng[1])!
            var multiplier = 2.0
            if let countryArea = chosenCountry!.area
            {
                if countryArea < 200
                {
                    multiplier = 0.1
                }
                else if countryArea > 100000.0
                {
                    multiplier = 10.0
                }
                else if countryArea > 1000000.0
                {
                    multiplier = 75.0
                }
        }
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), span: MKCoordinateSpan(latitudeDelta: Double(multiplier), longitudeDelta: Double(multiplier)))
        myMap.setRegion(region,animated:true)
        }
    }
}
