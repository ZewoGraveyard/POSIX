import XCTest
@testable import POSIX

class POSIXTests: XCTestCase {
    func testReality() {
        XCTAssert(2 + 2 == 4, "Something is severely wrong here.")
    }
}

extension POSIXTests {
    static var allTests : [(String, (POSIXTests) -> () throws -> Void)] {
        return [
           ("testReality", testReality),
        ]
    }
}
