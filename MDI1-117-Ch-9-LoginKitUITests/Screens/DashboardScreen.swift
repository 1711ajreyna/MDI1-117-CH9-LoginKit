import XCTest

struct DashboardScreen {
    let app: XCUIApplication

    var welcomeLabel: XCUIElement {
        app.staticTexts["welcome_label"]
    }

    var logoutButton: XCUIElement {
        app.buttons["logout_button"]
    }

    @discardableResult
    func logout() -> Self {

        XCTAssertTrue(
            logoutButton.waitUntilHittable(timeout: 5),
            "Logout button did not become hittable"
        )

        logoutButton.tap()

        return self
    }
}
