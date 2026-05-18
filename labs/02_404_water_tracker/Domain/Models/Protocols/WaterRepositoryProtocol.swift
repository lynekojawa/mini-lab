import Foundation

/// Abstract repository interface for water chemistry data.
///
/// Architectural Responsibilities:
/// - Defines async data access contracts
/// - Hides persistence implementation details
/// - Enables dependency inversion
///
/// Architectural Invariants:
/// - Features must depend ONLY on this protocol
/// - Domain must not know Firebase/Firestore
/// - Repository contracts remain implementation-agnostic
///
/// Coupling Risks Prevented:
/// - Prevents ViewModels from importing Firebase
/// - Prevents vendor lock-in
/// - Prevents integration-only testing
/// - Prevents direct persistence coupling
protocol WaterRepositoryProtocol {

    /// Fetches all water readings.
    ///
    /// Expected Behavior:
    /// - Returns readings sorted by timestamp descending
    /// - Throws domain-safe errors on failure
    ///
    /// Error Handling Notes:
    /// - Network failures
    /// - Permission failures
    /// - Data decoding failures
    func fetchReadings() async throws -> [WaterReading]

    /// Persists a new water reading.
    ///
    /// Error Handling Notes:
    /// - Validation failures
    /// - Encoding failures
    /// - Remote persistence failures
    func saveReading(
        _ reading: WaterReading
    ) async throws

    /// Deletes an existing reading.
    ///
    /// Error Handling Notes:
    /// - Missing document
    /// - Permission denial
    /// - Connectivity failures
    func deleteReading(
        id: String
    ) async throws
}//
//  WaterRepositoryProtocol.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/14/26.
//

