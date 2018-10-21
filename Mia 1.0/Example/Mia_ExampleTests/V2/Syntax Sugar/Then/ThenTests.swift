import XCTest
@testable import Mia

class ThenTests: XCTestCase {

    override func setUp() {

        UserDefaults.resetStandardUserDefaults()
    }

    func testDo() {

        XCTAssertEqual(UserDefaults.standard.string(forKey: "username"), nil)
        UserDefaults.standard.do {
            $0.set("multinerd", forKey: "username")
        }
        XCTAssertEqual(UserDefaults.standard.string(forKey: "username"), "multinerd")
    }

    func testRethrows() {

        XCTAssertThrowsError(try NSObject().do { _ in
            throw ThenError.test
        })
    }

    func testThen() {

        let queue = OperationQueue().then {
            $0.name = "api"
            $0.maxConcurrentOperationCount = 5
        }
        XCTAssertEqual(queue.name, "api")
        XCTAssertEqual(queue.maxConcurrentOperationCount, 5)
    }

    func testWith() {

        let user = User().with {
            $0.name = "multinerd"
            $0.email = "mike@multinerd.io"
        }
        XCTAssertEqual(user.name, "multinerd")
        XCTAssertEqual(user.email, "mike@multinerd.io")
    }

}

struct User {
    var name: String?
    var email: String?
}

extension User: Then {
}

public enum ThenError: Error {
    case test
}
