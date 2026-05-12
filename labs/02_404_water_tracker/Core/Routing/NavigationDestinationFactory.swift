import SwiftUI

/// Responsible for resolving Routes into Views.
///
/// Architectural Invariant:
/// - Routing resolution is centralized.
/// - Feature modules do not instantiate each other directly.
///
/// Coupling Risks Prevented:
/// - Prevents feature-to-feature imports.
/// - Prevents circular dependencies.
/// - Prevents navigation fragmentation.
struct NavigationDestinationFactory {

    @ViewBuilder
    static func build(
        route: Route
    ) -> some View {

        switch route {

        case .dashboard:
            Text("Dashboard Placeholder")

        case .waterTracking:
            Text("Water Tracking Placeholder")

        case .addWaterReading:
            Text("Add Water Reading Placeholder")

        case .feeding:
            Text("Feeding Placeholder")

        case .activity:
            Text("Activity Placeholder")

        case .history:
            Text("History Placeholder")

        case .settings:
            Text("Settings Placeholder")

        case .waterReadingDetail(let id):
            Text("Water Reading Detail: \(id)")
        }
    }
}