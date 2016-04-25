#if os(Linux)

import XCTest
@testable import POSIXTestSuite

XCTMain([
    testCase(POSIXTests.allTests)
])

#endif
