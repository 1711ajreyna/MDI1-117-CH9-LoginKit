import XCTest

extension XCUIElement {

    // Waits until the element exists AND can receive a tap.
    @discardableResult
    func waitUntilHittable(timeout: TimeInterval = 5) -> Bool {
        let deadline = Date().addingTimeInterval(timeout)

        while Date() < deadline {

            if self.exists && self.isHittable {
                return true
            }

            RunLoop.current.run(
                until: Date().addingTimeInterval(0.1)
            )
        }

        return self.exists && self.isHittable
    }


    // Wait until a property of the element matches a predicate.
    // Example: loginButton.wait(until: "isEnabled == true")
    @discardableResult
    func wait(
        until format: String,
        timeout: TimeInterval = 5
    ) -> Bool {

        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: format),
            object: self
        )

        return XCTWaiter()
            .wait(
                for: [expectation],
                timeout: timeout
            ) == .completed
    }


    // TODO (Exercise 9):
    // add clearAndType(_ text: String)
    //
    // tap → delete whatever is already in the field
    // → type the new text
}
