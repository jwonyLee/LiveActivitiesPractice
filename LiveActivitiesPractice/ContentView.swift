//
//  ContentView.swift
//  LiveActivitiesPractice
//
//  Created by 이지원 on 2022/08/07.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
    @State private var fee: Int = 0
    @State private var estimatedDistance: Double = 0.0
    @State private var estimatedRidingTime: Date = Date()
    @State private var timer: Timer? = nil

    @State private var ridingActivity: Activity<RidingAttributes>?

    var body: some View {
        VStack {
            Button("Start Live Activities") {
                startLiveActivities()
                updateData()
            }
            .padding()

            Button("Stop Live Activites") {
                stopLiveActivities()
            }
            .padding()
        }
    }

    private func startLiveActivities() {
        if ridingActivity != nil {
            return
        }

        let ridingAttributes = RidingAttributes()

        let initialContentState = RidingAttributes.RidingStatus(
            fee: fee,
            estimatedDistance: estimatedDistance,
            estimatedRidingTime: estimatedRidingTime
        )

        do {
            ridingActivity = try Activity<RidingAttributes>.request(
                attributes: ridingAttributes,
                contentState: initialContentState,
                pushType: nil
            )
            print("Requested a riding Live Activity \(ridingActivity?.id)")
        } catch (let error) {
            print("Error requesting riding Live Activity \(error.localizedDescription)")
        }
    }

    private func updateData() {
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { _ in
            self.estimatedDistance += Double.random(in: 0...3)
            self.fee = 400 + (150 * Int(estimatedDistance))
            self.updateLiveActivities()
        }
    }

    private func updateLiveActivities() {
        Task {
            let updatedRidingStatus = RidingAttributes.RidingStatus(
                fee: fee,
                estimatedDistance: estimatedDistance,
                estimatedRidingTime: estimatedRidingTime
            )

            await ridingActivity?.update(using: updatedRidingStatus)
        }
    }

    private func stopLiveActivities() {
        Task {
            let updatedRidingStatus = RidingAttributes.RidingStatus(
                fee: 0,
                estimatedDistance: 0,
                estimatedRidingTime: Date()
            )

            do {
                try await ridingActivity?.end(using: updatedRidingStatus, dismissalPolicy: .immediate)
                timer?.invalidate()
            } catch(let error) {
                print("Error ending activity \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
