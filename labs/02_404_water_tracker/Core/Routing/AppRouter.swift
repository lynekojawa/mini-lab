import Foundation
import SwiftUI

/// Global application router.
///
/// Responsibilities:
/// - Own navigation state.
/// - Coordinate stack mutations.
/// - Provide deterministic navigation behavior.
///
/// Architectural Invariants:
/// - Navigation mutations ONLY occur here.
/// - Router is MainActor isolated.
/// - Router never performs business logic.
///
/// Coupling Risks Prevented:
/// - Prevents Views from coordinating navigation independently.
/// - Prevents feature modules from mutating global navigation state.
/// - Prevents race conditions during async navigation updates.
@MainActor
final class AppRouter: ObservableObject {

    /// Navigation path used by NavigationStack.
    @Published var path: [Route] = []

    // MARK: - Push

    func push(_ route: Route) {
        path.append(route)
    }

    // MARK: - Pop

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    // MARK: - Pop To Root

    func popToRoot() {
        path.removeAll()
    }

    // MARK: - Replace Stack

    /// Replaces the entire navigation stack.
    ///
    /// Useful for:
    /// - auth transitions
    /// - deep links
    /// - app restoration
    func replace(with routes: [Route]) {
        path = routes
    }
}