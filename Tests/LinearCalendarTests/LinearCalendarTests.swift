import XCTest
@testable import LinearCalendar

final class LinearCalendarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LinearCalendar().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
