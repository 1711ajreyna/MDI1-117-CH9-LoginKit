import XCTest

struct LoginScreen {
    let app: XCUIApplication
    
    var emailField: XCUIElement { app.textFields["email_field"] }
    var passwordField: XCUIElement { app.secureTextFields["password_field"] }
    var loginButton: XCUIElement { app.buttons["login_button"] }
    var errorLabel: XCUIElement { app.staticTexts["error_label"] }
    var rememberMeToggle: XCUIElement { app.switches["remember_me_toggle"] }
    
    @discardableResult
    func login(email: String, password: String, rememberMe: Bool = false) -> Self {
        if rememberMe {
            setRememberMe(true)
        }
        emailField.tap()
        emailField.typeText(email)
        passwordField.tap()
        passwordField.typeText(password)
        loginButton.tap()
        return self
    }
    
    @discardableResult
    func setRememberMe(_ on: Bool) -> Self {
        let isOn = (rememberMeToggle.value as? String) == "1"
        if isOn != on {
            rememberMeToggle.coordinate(withNormalizedOffset: CGVector(dx: 0.92, dy: 0.5)).tap()
        }
        return self
    }
}
