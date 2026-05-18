//
//  MockWaterRepository.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/14/26.
//
struct MockWaterRepository: WaterRepositoryProtocol {
    func fetchReadings() async throws ->[WaterReading]{
        return[WaterReading(ph:7.0, ammonia: 0.1, nitrite: 0.0, nitrate: 5.0)]
    }
    
    func saveReading(_ reading:WaterReading) async throws {
        print("Mock: Success!")
    }
    
    func deleteReading(id: String) async throws{
        print("Mock: Failure!")
    }
}
