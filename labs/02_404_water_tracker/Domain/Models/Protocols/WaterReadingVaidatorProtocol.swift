//
//  WaterReadingVaidatorProtocol.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/18/26.
//
import Foundation

/// Contract for validating WaterReading domain models.
///
/// Architectural Responsibilities:
/// - Defines validation boundaries for water chemistry data.
/// - Ensures mathematical invariants are enforced consistently.
/// - Keeps validation logic outside UI and ViewModels.
///
/// Architectural Invariants:
/// - Validation must remain deterministic.
/// - Validation must be side-effect free.
/// - Validation must not depend on external systems.
///
/// Coupling Risks Prevented:
/// - Prevents duplicated validation logic across Features.
/// - Prevents Views from implementing business rules.
/// - Prevents Firebase-specific validation leakage into Domain.
protocol WaterReadingValidatorProtocol {

    /// Validates a WaterReading instance.
    ///
    /// - Parameter reading: The domain model to validate.
    ///
    /// - Throws:
    ///   - ValidationError.invalidPH
    ///   - ValidationError.negativeChemicalValue
    ///
    /// Expected Behavior:
    /// - Throws if any mathematical invariant is violated.
    /// - Returns silently if validation succeeds.
    func validate(
        _ reading: WaterReading
    ) throws
}
