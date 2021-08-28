

//  Model_Profile.swift
//  YOLO


//  Created by Boons&Blessings Apps on 12/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import Foundation


// MARK: - Profile
struct Profile: Codable {
    let id: Int?
    let fullName: String?
    let profile: String?
    let gender, age, height, weight: String?
    let weightUnit: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case profile, gender, age, height, weight
        case weightUnit = "weight_unit"
    }
    
}


var profile:Profile?

