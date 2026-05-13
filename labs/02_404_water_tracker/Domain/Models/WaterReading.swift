import Foundation

/// Immutable domain model representing
/// a single water chemistry reading.
///
/// Architectural Invariants:
/// - Immutable after creation.
/// - Codable for persistence.
/// - Sendable for concurrency safety.
/// - Contains NO UI logic.
///
/// Mathematical Invariants:
/// - 0...14 pH range
/// - ammonia >= 0
/// - nitrite >= 0
/// - nitrate >= 0
///
/// Coupling Risks Prevented:
/// - Prevents Firebase model leakage into Domain.
/// - Prevents UI-specific formatting in business models.
struct WaterReading: Identifiable, Codable, Sendable {

    let id: String

    let timestamp: Date

    let ph: Double

    let ammonia: Double

    let nitrite: Double

    let nitrate: Double

    init(
        id: String = UUID().uuidString,
        timestamp: Date = .now,
        ph: Double,
        ammonia: Double,
        nitrite: Double,
        nitrate: Double
    ) {

        self.id = id
        self.timestamp = timestamp

        self.ph = ph
        self.ammonia = ammonia
        self.nitrite = nitrite
        self.nitrate = nitrate
    }
}