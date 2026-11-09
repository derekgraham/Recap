import SwiftUI
import UIKit

struct FeatureRow: View {
    @Environment(\.recapScreenIconFillMode) private var iconFillMode
    @Environment(\.recapScreenIconAlignment) private var iconAlignment

    let feature: Feature
    var usesShortDescription = false

    var body: some View {
        HStack(alignment: iconAlignment, spacing: 16.0) {
            ZStack(alignment: Alignment(horizontal: .center, vertical: iconAlignment)) {
                Color.clear
                    .frame(width: 48.0, height: 48.0)

                self.icon
                    .foregroundStyle(self.iconForegroundStyle)
                    .font(.system(size: 32.0))
            }

            VStack(alignment: .leading, spacing: 4.0) {
                Text(.init(feature.title))
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(.init(self.description))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private extension FeatureRow {
    var description: String {
        if self.usesShortDescription, let shortDescription = self.feature.shortDescription {
            shortDescription
        } else {
            self.feature.description
        }
    }

    /// The SF Symbol when this OS has it, otherwise the asset catalog image, so a release can name
    /// a newer symbol and ship a copy of it for older systems.
    var icon: Image {
        if let imageName = self.feature.imageName, UIImage(systemName: self.feature.symbolName) == nil {
            Image(imageName)
        } else {
            Image(systemName: self.feature.symbolName)
        }
    }

    var iconForegroundStyle: AnyShapeStyle {
        switch self.iconFillMode {

        case .gradient:
            AnyShapeStyle(self.feature.color.gradient)

        case .solid:
            AnyShapeStyle(self.feature.color)
        }
    }
}
