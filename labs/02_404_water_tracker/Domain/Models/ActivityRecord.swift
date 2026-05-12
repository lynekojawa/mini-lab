import Foundation

/// Represents observed aquatic activity.
///
/// Architectural Invariants:
/// - Immutable
/// - Deterministic
/// - Persistence-friendly
///
/// Mathematical Invariants:
/// - activityScore must remain within 0...100
///
/// Coupling Risks Prevented:
/// - Prevents analytics logic from leaking into UI.
struct ActivityRecord: Identifiable, Codable, Sendable {

    let id: String

    let timestamp: Date

    /// Normalized score between 0 and 100.
    let activityScore: Int

    let notes: String?

    init(
        id: String = UUID().uuidString,
        timestamp: Date = .now,
        activityScore: Int,
        notes: String? = nil
    ) {

        self.id = id
        self.timestamp = timestamp
        self.activityScore = activityScore
        self.notes = notes
    }
}