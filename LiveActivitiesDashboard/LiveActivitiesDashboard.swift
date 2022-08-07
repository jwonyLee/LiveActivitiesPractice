//
//  LiveActivitiesDashboard.swift
//  LiveActivitiesDashboard
//
//  Created by 이지원 on 2022/08/07.
//

import ActivityKit
import SwiftUI
import WidgetKit

@main
struct LiveActivitiesDashboard: WidgetBundle {
    var body: some Widget {
        RidingActivityWidget()
    }
}

struct RidingActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(attributesType: RidingAttributes.self) { context in
            VStack {
                HStack {
                    VStack(alignment: .center) {
                        Text("\(context.state.fee) 원")
                            .font(.headline)
                        Text("요금")
                    }
                    .frame(maxWidth: .infinity)

                    VStack(alignment: .center) {
                        Text(context.state.estimatedRidingTime, style: .timer)
                            .font(.headline)
                        Text("주행 시간")
                    }
                    .frame(maxWidth: .infinity)

                    VStack(alignment: .center) {
                        Text("\(String(format: "%.2f", context.state.estimatedDistance)) km")
                            .font(.headline)
                        Text("주행 거리")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
