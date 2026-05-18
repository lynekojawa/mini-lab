//
//  _2_404_water_trackerApp.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/13/26.
//

import SwiftUI

@main
struct _2_404_water_trackerApp: App {
    var body: some Scene {
        WindowGroup {
            let mockRepository = MockWaterRepository()
            WaterTrackingViews(repository: mockRepository)
        }
    }
}
