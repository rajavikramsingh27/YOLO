//
//  Model_GetDonners.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 06/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import Foundation



// MARK: - GetDonnerElement
struct GetDonner: Codable {
    let id: Int
    let fullName: String
    let profile: String
    let noOfUnits: Int
    let unit: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case profile
        case noOfUnits = "no_of_units"
        case unit
    }
}

var arrGetDonner:[GetDonner] = []
