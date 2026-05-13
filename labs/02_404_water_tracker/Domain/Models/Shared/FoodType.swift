import Foundation
/// if this divides food types with following four, we need to change because most I use is pallet, maybe
/// Supported food categories.
///
/// Architectural Invariant:
/// - Shared enums belong in Domain.
/// - Enums remain presentation-agnostic.
///
/// Coupling Risks Prevented:
/// - Prevents duplicated enums across Features.
/// - Prevents UI labels becoming business identifiers.
enum FoodType: String, Codable, CaseIterable, Sendable {

    case pellets
    case flakes
    case frozen
    case live
}

