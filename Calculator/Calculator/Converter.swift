//
//  Converter.swift
//  Calculator
//
//  Created by Boao Huang on 4/12/19.
//  Copyright © 2019 Boao Huang. All rights reserved.
//

import Foundation

struct Converter {
    let label: String
    let inputUnit: String
    let outputUnit: String
    let convert: (Double)->Double
}

