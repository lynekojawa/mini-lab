//
//  WaterTrackingViewModel.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/18/26.
//
import Foundation
import Combine

@MainActor
final class WaterTrackingViewModel: ObservableObject {
    private let repository: WaterRepositoryProtocol
    private let validator: WaterReadingValidatorProtocol
    
    @Published var readings: [WaterReading] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    init(
        repository: WaterRepositoryProtocol,
        validator: WaterReadingValidatorProtocol
    ) {
        self.repository = repository
        self.validator = validator
    }
    
    func addReading(_ reading: WaterReading) async {
        do {
            try validator.validate(reading)
            
            try await repository.save(reading)
            
            readings = try await repository.fetchAll()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
