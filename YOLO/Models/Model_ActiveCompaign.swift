//
//  Model_ActiveCompaign.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 10/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import Foundation



// MARK: - ActiveCompaignElement
struct ActiveCompaign: Codable {
    let id: Int
    let name: String
    let ngoID: Int
    let startDate, endDate: String
    let thumbnail: String
    let campaignType, goalUnit: String
    let primaryGoalTarget, primaryGoalProgress, primaryGoalProgressPercentage, daysLeft: Int
    let ngo: Ngo

    enum CodingKeys: String, CodingKey {
        case id, name
        case ngoID = "ngo_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case thumbnail
        case campaignType = "campaign_type"
        case goalUnit = "goal_unit"
        case primaryGoalTarget = "primary_goal_target"
        case primaryGoalProgress = "primary_goal_progress"
        case primaryGoalProgressPercentage = "primary_goal_progress_percentage"
        case daysLeft = "days_left"
        case ngo
    }
}



var arrActiveCompaign : [ActiveCompaign] = []
