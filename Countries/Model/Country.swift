//
//  Country.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import Foundation

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
    var area : Double?
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

