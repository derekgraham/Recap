import SwiftUI

/// Represents an individual feature to be displayed on the `RecapScreen`.
public struct Feature: Identifiable, Equatable {
    public let id = UUID()

    public let title: String
    public let description: String
    public let symbolName: String
    public let colorRepresentation: String

    /// The name of a custom symbol or image in the app's asset catalog. It is shown when this OS
    /// has no SF Symbol named `symbolName`: always when `symbolName` is empty, or in place of a
    /// symbol that is newer than the OS.
    public let imageName: String?

    public init(title: String, description: String, symbolName: String, colorRepresentation: String, imageName: String? = nil) {
        self.title = title
        self.description = description
        self.symbolName = symbolName
        self.colorRepresentation = colorRepresentation
        self.imageName = imageName
    }
}

internal extension Feature {
    var color: Color {
        if self.colorRepresentation.hasPrefix("#") {
            return Color(hex: self.colorRepresentation)
        } else if let color = Color(systemName: self.colorRepresentation) {
            return color
        } else {
            return .black
        }
    }
}
