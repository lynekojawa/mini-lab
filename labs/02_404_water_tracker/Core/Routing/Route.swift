import Foundation

/// Centralized application navigation routes.
///
/// Architectural Invariant:
/// - Routes are pure value types.
/// - Routes contain NO business logic.
/// - Routes must remain Hashable for NavigationStack compatibility.
///
/// Coupling Risk Prevented:
/// - Prevents feature modules from directly depending
///   on concrete destination implementations.
enum Route: Hashable {

    case dashboard

    case waterTracking

    case addWaterReading

    case feeding

    case activity

    case history

    case settings

    /// Example of parameterized navigation.
    ///
    /// Use IDs instead of passing full models to:
    /// - reduce memory retention
    /// - prevent stale object propagation
    /// - maintain navigation determinism
    case waterReadingDetail(id: String)
}