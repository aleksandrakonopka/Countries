//
//  Providing.swift
//  Countries
//
//  Created by Aleksandra Konopka on 04/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import Foundation
protocol Providing{
    func fetch(completion : @escaping ([Country]?,Error?) -> Void)
}
