import XCTest
//@testable import Nome

final class NomeTests: XCTestCase {
    
    func testInitError() {
//        let filePath = URL(fileURLWithPath: "")

//        XCTAssertThrowsError(try Nome(audioFilePath: filePath))
    }

    static var allTests = [
        ("Throws an error when initialized with incorrect filepath", testInitError),
    ]
}
