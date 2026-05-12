import Foundation

/// Represents a feeding event.
///
/// Architectural Invariants:
/// - Immutable
/// - Codable
/// - UI-independent
///
/// Mathematical Invariants:
/// - quantity > 0
///
/// Coupling Risks Prevented:
/// - Prevents feature-layer enums from leaking into Domain.
struct FeedingRecord: Identifiable, Codable, Sendable {

    let id: String

    let timestamp: Date

    let foodType: FoodType

    let quantity: Double

    init(
        id: String = UUID().uuidString,
        timestamp: Date = .now,
        foodType: FoodType,
        quantity: Double
    ) {

        self.id = id
        self.timestamp = timestamp
        self.foodType = foodType
        self.quantity = quantity
    }
}