

//  Model_CompaignDetails.swift
//  YOLO


//  Created by Boons&Blessings Apps on 06/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import Foundation

var compaignDetails:CompaignDetails!

// MARK: - Getgrinds
struct CompaignDetails: Codable {
    let id: Int?
    let name: String?
    let ngoID: Int?
    let startDate, endDate: String?
    let thumbnail: String?
    let campaignType: String?
    let conversionFactor: Double?
    let goalUnit: String?
    let hasGrinds: Int?
    let getgrindsDescription: String?
    let primaryGoalTarget, primaryGoalProgress: Int?
    let primaryGoalProgressPercentage: Double?
    let daysLeft: Int?
    let gallery: [Gallery]?
    let ngo: Ngo?
    let myContribution: MyContribution?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case ngoID = "ngo_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case thumbnail
        case campaignType = "campaign_type"
        case conversionFactor = "conversion_factor"
        case goalUnit = "goal_unit"
        case hasGrinds = "has_grinds"
        case getgrindsDescription = "description"
        case primaryGoalTarget = "primary_goal_target"
        case primaryGoalProgress = "primary_goal_progress"
        case primaryGoalProgressPercentage = "primary_goal_progress_percentage"
        case daysLeft = "days_left"
        case gallery, ngo
        case myContribution = "my_contribution"
    }
}

// MARK: - Gallery
struct Gallery: Codable {
    let id, campaignID: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case campaignID = "campaign_id"
        case image
    }
}

// MARK: - MyContribution
struct MyContribution: Codable {
    let contributionID, campaignID, goalUnits, goalGrinds: Int?
    let goalUnitProgress, goalGrindProgress, goalUnitProgressPercentage, goalGrindProgressPercentage: Int?

    enum CodingKeys: String, CodingKey {
        case contributionID = "contribution_id"
        case campaignID = "campaign_id"
        case goalUnits = "goal_units"
        case goalGrinds = "goal_grinds"
        case goalUnitProgress = "goal_unit_progress"
        case goalGrindProgress = "goal_grind_progress"
        case goalUnitProgressPercentage = "goal_unit_progress_percentage"
        case goalGrindProgressPercentage = "goal_grind_progress_percentage"
    }
    
}



