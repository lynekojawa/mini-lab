//
//  WaterTrackingViews.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/18/26.
//
import SwiftUI

struct WaterTrackingViews: View {
    @StateObject private var viewModel: WaterTrackingViewModel
    
    init(repository: WaterRepositoryProtocol){
        _viewModel = StateObject(wrappedValue: WaterTrackingViewModel(repository: repository))
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.readings) { reading in
                HStack {
                    Text("pH: \(reading.ph, specifier: "%.1f")")
                    Spacer()
                    Text("Time: \(reading.timestamp, style: .date)")
                }
            }
            .navigationTitle("Water Tracker")
            .task {
                await viewModel.loadReadings()
            }
        }
    }
}
