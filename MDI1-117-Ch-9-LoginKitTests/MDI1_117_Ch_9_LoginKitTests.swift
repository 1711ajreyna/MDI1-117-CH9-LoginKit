import XCTest
@testable import MDI1_117_Ch_9_LoginKit

final class MDI1_117_Ch_9_LoginKitTests: XCTestCase {
    @MainActor
    func test_validLogin_setsLoggedInUser() async {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let store = SessionStore(defaults: defaults)
        defer { store.clear() }
        let viewModel = LoginViewModel(authService: AuthService(), sessionStore: store)
        viewModel.email = "test@mail.com"
        viewModel.password = "test1234"

        await viewModel.login()

        XCTAssertEqual(viewModel.loggedInUser?.email, "test@mail.com")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    @MainActor
    func test_invalidLogin_setsErrorAndDoesNotLogIn() async {
        let defaults = UserDefaults(suiteName: UUID().uuidString)!
        let store = SessionStore(defaults: defaults)
        defer { store.clear() }
        let viewModel = LoginViewModel(authService: AuthService(), sessionStore: store)
        viewModel.email = "test@mail.com"
        viewModel.password = "wrong-password"

        await viewModel.login()

        XCTAssertNil(viewModel.loggedInUser)
        XCTAssertEqual(viewModel.errorMessage, "Invalid email or password")
        XCTAssertFalse(viewModel.isLoading)
    }
}
