//
//  _2_404_water_trackerTests.swift
//  02_404_water_trackerTests
//
//  Created by Lynn Sherman on 5/13/26.
//

import Testing
@testable import _2_404_water_tracker
import Foundation

@MainActor
struct _2_404_water_trackerTests {

    @Test
    func testMockRepositoryFetchesData() async throws {
        let repo = MockWaterRepository()
        let readings = try await repo.fetchReadings()
        
        #expect(readings.count == 1, "it needs to be exact one data")
        #expect(readings.first?.ph == 7.0, "pH should be 7.0")
    }

}
