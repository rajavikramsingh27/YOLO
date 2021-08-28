//
//  Model_LoginFacebook.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 06/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import Foundation

// MARK: - LoginFacebook
struct LoginFacebook: Codable {
    let token, message: String
    let error: Bool
}
