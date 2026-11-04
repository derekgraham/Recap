import Testing
@testable import Recap

@Suite("ReleasesParser Tests")
struct ReleasesParserTests {
    @Test("Parsing Valid Markdown")
    func parsingValidMarkdown() {
        let markdown = """
        # 1.0.0
        ## Initial Release
        ### major
        
        - title: New Feature
        - description: This is a new feature
        - symbol: star
        - color: #FF0000
        
        - title: Another Feature
        - description: This is another feature
        - symbol: cloud
        - color: #00FF00
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        #expect(releases.count == 1)
        #expect(releases[0].version.string == "1.0.0")
        #expect(releases[0].title == "Initial Release")
        #expect(releases[0].version.change == .major)
        #expect(releases[0].features.count == 2)

        #expect(releases[0].features[0].title == "New Feature")
        #expect(releases[0].features[0].description == "This is a new feature")
        #expect(releases[0].features[0].symbolName == "star")
        #expect(releases[0].features[0].colorRepresentation == "#FF0000")

        #expect(releases[0].features[1].title == "Another Feature")
        #expect(releases[0].features[1].description == "This is another feature")
        #expect(releases[0].features[1].symbolName == "cloud")
        #expect(releases[0].features[1].colorRepresentation == "#00FF00")
    }

    @Test("Parsing Multiple Releases")
    func parsingMultipleReleases() {
        let markdown = """
        # 2.0.0
        ## Major Update
        ### major
        
        - title: Breaking Change
        - description: This is a breaking change
        - symbol: exclamationmark.triangle
        - color: FF0000
        
        # 1.1.0
        ## Minor Update
        ### minor
        
        - title: New Feature
        - description: This is a new feature
        - symbol: star
        - color: 00FF00
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        #expect(releases.count == 2)
        #expect(releases[0].version.string == "1.1.0")
        #expect(releases[1].version.string == "2.0.0")
    }

    @Test("Parsing With Missing Optional Fields")
    func parsingWithMissingOptionalFields() {
        let markdown = """
        # 1.0.0
        ## Initial Release
        ### patch
        
        - title: Basic Feature
        - description: This is a basic feature
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        #expect(releases.count == 1)
        #expect(releases[0].features[0].symbolName == "heart")
        #expect(releases[0].features[0].colorRepresentation == "#000000")
    }

    @Test("Parsing A Custom Image")
    func parsingCustomImage() {
        let markdown = """
        # 1.0.0
        ## Test Release
        ### minor

        - title: Custom Icon
        - description: Uses an image from the app's asset catalog
        - image: custom.icon
        - color: #FF0000

        - title: Newer Symbol
        - description: Uses the symbol where the OS has it, a copy elsewhere
        - symbol: pad.header
        - image: pad.header.copy

        - title: System Icon
        - description: Uses an SF Symbol
        - symbol: star

        - title: No Icon
        - description: Falls back to the default symbol
        """

        let parser = ReleasesParser(markdown: markdown)
        let features = parser.releases[0].features

        #expect(features[0].imageName == "custom.icon")
        #expect(features[0].symbolName == "")
        #expect(features[0].colorRepresentation == "#FF0000")
        #expect(features[1].imageName == "pad.header.copy")
        #expect(features[1].symbolName == "pad.header")
        #expect(features[2].imageName == nil)
        #expect(features[2].symbolName == "star")
        #expect(features[3].imageName == nil)
        #expect(features[3].symbolName == "heart")
    }

    @Test("Parsing With Escape Sequences")
    func parsingWithEscapeSequences() {
        let markdown = """
        # 1.0.0
        ## Test Release
        ### minor
        
        - title: Feature with Escapes
        - description: This feature has a \\n newline and a \\\\ backslash
        """

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        #expect(releases[0].features[0].description == "This feature has a \n newline and a \\ backslash")
    }

    @Test("Parse Empty Markdown")
    func testParseEmptyMarkdown() {
        let markdown = ""

        let parser = ReleasesParser(markdown: markdown)
        let releases = parser.releases

        #expect(releases.isEmpty)
    }
}
