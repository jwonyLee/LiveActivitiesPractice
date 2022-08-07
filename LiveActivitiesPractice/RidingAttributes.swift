//
//  RidingAttributes.swift
//  LiveActivitiesPractice
//
//  Created by 이지원 on 2022/08/07.
//

import Foundation
import WidgetKit
import ActivityKit

public struct RidingAttributes: ActivityAttributes {
    public typealias RidingStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var fee: Int
        var estimatedDistance: Double
        var estimatedRidingTime: Date
    }
}
