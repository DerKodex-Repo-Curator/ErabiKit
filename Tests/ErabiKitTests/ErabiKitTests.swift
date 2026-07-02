import XCTest
import SwiftUI
@testable import ErabiKit

final class ErabiKitTests: XCTestCase {
    func testMailRowObjectStoresEmailConfiguration() {
        let object = MailRowObject(
            receiver: "support@example.com",
            subject: "Feedback",
            body: "I love this app"
        )

        XCTAssertEqual(object.receiver, "support@example.com")
        XCTAssertEqual(object.subject, "Feedback")
        XCTAssertEqual(object.body, "I love this app")
    }

    func testSettingsRowStoresPublicInitializerConfiguration() {
        let row = SettingsRow(
            imageName: "star",
            title: "Favorites",
            addOverlay: false,
            showDisclosure: false
        )

        XCTAssertEqual(storedValue("imageName", in: row), "star")
        XCTAssertEqual(storedValue("title", in: row), "Favorites")
        XCTAssertEqual(storedValue("addOverlay", in: row), false)
        XCTAssertEqual(storedValue("showDisclosure", in: row), false)
    }

    func testAboutRowStoresAccessibilityConfiguration() {
        let row = AboutRow(
            title: "Made with love by Rudrank Riyam",
            accessibilityTitle: "Made with love by Rudrank Riyam"
        )

        XCTAssertEqual(storedValue("title", in: row), "Made with love by Rudrank Riyam")
        XCTAssertEqual(storedValue("accessibilityTitle", in: row), "Made with love by Rudrank Riyam")
    }

    func testActionRowStoresActionConfiguration() throws {
        var didRunAction = false
        let row = SettingsActionRow(imageName: "trash", title: "Clear Cache", addOverlay: false) {
            didRunAction = true
        }

        XCTAssertEqual(storedValue("imageName", in: row), "trash")
        XCTAssertEqual(storedValue("title", in: row), "Clear Cache")
        XCTAssertEqual(storedValue("addOverlay", in: row), false)

        let action = try XCTUnwrap(storedValue("action", in: row) as (() -> Void)?)
        action()
        XCTAssertTrue(didRunAction)
    }

    private func storedValue<T>(_ label: String, in subject: Any) -> T? {
        Mirror(reflecting: subject).children.first { $0.label == label }?.value as? T
    }

    static var allTests = [
        ("testMailRowObjectStoresEmailConfiguration", testMailRowObjectStoresEmailConfiguration),
        ("testSettingsRowStoresPublicInitializerConfiguration", testSettingsRowStoresPublicInitializerConfiguration),
        ("testAboutRowStoresAccessibilityConfiguration", testAboutRowStoresAccessibilityConfiguration),
        ("testActionRowStoresActionConfiguration", testActionRowStoresActionConfiguration)
    ]
}
