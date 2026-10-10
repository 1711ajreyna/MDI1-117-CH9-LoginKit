import XCTest

final class MDI1_117_Ch_9_LoginKitUITests: XCTestCase {

    var app: XCUIApplication!
    var loginScreen: LoginScreen!
    var dashboardScreen: DashboardScreen!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITesting-Reset"]
        app.launch()
        loginScreen = LoginScreen(app: app)
        dashboardScreen = DashboardScreen(app: app)
    }
    /// Test #1 - Navigate to dashboard
    func test_successfulLogin_navigatesToDashboard() throws {
        loginScreen.login(email: "test@mail.com", password: "test1234")
        XCTAssertTrue(dashboardScreen.welcomeLabel.waitForExistence(timeout: 5))
    }
    
    /// Test #2 - Failure Path
    func test_invalidLogin_showsErrorMessage() throws {
        loginScreen.login(email: "testerror@mail.com",password: "wrongpassword")

        XCTAssertTrue(loginScreen.errorLabel.waitForExistence(timeout: 5))

        XCTAssertFalse(dashboardScreen.welcomeLabel.exists)
    }
    
    /// Test #3 -
    func test_logout_returnsToLoginScreen() throws {
        loginScreen.login(email: "test@mail.com", password: "test1234")

        XCTAssertTrue(dashboardScreen.welcomeLabel.waitForExistence(timeout: 10))

        dashboardScreen.logout()

        XCTAssertTrue(loginScreen.emailField.waitForExistence(timeout: 5))

        XCTAssertFalse(dashboardScreen.welcomeLabel.exists)
    }
}
