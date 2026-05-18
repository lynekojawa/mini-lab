//
//  WaterReadingValidator.swift
//  02_404_water_tracker
//
//  Created by Lynn Sherman on 5/18/26.
//
import Foundation

/// Domain validation errors for water chemistry readings.
///
/// Architectural Invariants:
/// - Errors remain domain-focused.
/// - Errors contain no UI formatting logic.
/// - Errors remain stable across persistence implementations.
///
/// Coupling Risks Prevented:
/// - Prevents Firebase/network errors from leaking into Domain.
/// - Prevents ViewModels from inventing validation rules.
enum ValidationError: LocalizedError, Equatable {

    case invalidPH(value: Double)

    case negativeChemicalValue(
        chemical: ChemicalType,
        value: Double
    )

    // MARK: - LocalizedError

    var errorDescription: String? {

        switch self {

        case .invalidPH(let value):
            return "Invalid pH value: \(value). pH must be between 0.0 and 14.0."

        case .negativeChemicalValue(let chemical, let value):
            return "\(chemical.rawValue.capitalized) cannot be negative. Received value: \(value)."
        }
    }
}

/// Supported chemical identifiers used for validation.
///
/// Architectural Invariants:
/// - Shared domain enums remain presentation-agnostic.
/// - Raw values are persistence-safe.
enum ChemicalType: String, Codable, Sendable {

    case ammonia
    case nitrite
    case nitrate
}

/// Concrete implementation of WaterReadingValidatorProtocol.
///
/// Responsibilities:
/// - Enforces mathematical correctness.
/// - Guards domain invariants before persistence.
/// - Provides deterministic validation behavior.
///
/// Architectural Invariants:
/// - Stateless
/// - Pure validation logic only
/// - No external dependencies
///
/// Coupling Risks Prevented:
/// - Prevents validation duplication.
/// - Prevents persistence layer from becoming business-aware.
/// - Prevents UI logic contamination.
struct WaterReadingValidator: WaterReadingValidatorProtocol {

    // MARK: - Validation

    func validate(
        _ reading: WaterReading
    ) throws {

        try validatePH(reading.ph)

        try validateChemicalValue(
            reading.ammonia,
            chemical: .ammonia
        )

        try validateChemicalValue(
            reading.nitrite,
            chemical: .nitrite
        )

        try validateChemicalValue(
            reading.nitrate,
            chemical: .nitrate
        )
    }
}

// MARK: - Private Helpers

private extension WaterReadingValidator {

    func validatePH(
        _ value: Double
    ) throws {

        guard (0.0...14.0).contains(value) else {
            throw ValidationError.invalidPH(value: value)
        }
    }

    func validateChemicalValue(
        _ value: Double,
        chemical: ChemicalType
    ) throws {

        guard value >= 0.0 else {
            throw ValidationError.negativeChemicalValue(
                chemical: chemical,
                value: value
            )
        }
    }
}
