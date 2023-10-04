import XCTest
import SwiftUI
@testable import BigUIPaging

final class BigUIPagingTests: XCTestCase {
    
    func testSurroundingValues() {
        let configuration = PageViewStyleConfiguration(
            selection: .constant(.init(1))
        ) { value in
            PageViewStyleConfiguration.Value(value.wrappedValue as! Int + 1)
        } previous: { value in
            PageViewStyleConfiguration.Value(value.wrappedValue as! Int - 1)
        } content: { value in
            PageViewStyleConfiguration.Page(Text(""))
        }
        let (configValues, selectedIndex) = configuration.values(
            surrounding: PageViewStyleConfiguration.Value(5),
            limit: 2
        )
        let values = configValues.map { $0.wrappedValue as! Int }
        XCTAssertEqual(selectedIndex, 2)
        XCTAssertEqual(values.count, 5)
        XCTAssertEqual(values.first, 3)
        XCTAssertEqual(values.last, 7)
    }
    
    // MARK: - SwiftUI helpers

    func testLabelImage() {
        let view = Label("Hello World", systemImage: "person")
        let output = view._firstImage()
        XCTAssertNotNil(output)
    }
    
    func testImageSystemName() {
        let view = Image(systemName: "person")
        let output = view._systemName()
        XCTAssertEqual(output, "person")
    }
    
    #if os(iOS)
    func testSystemImage() {
        let view = Image(systemName: "person")
        XCTAssertNotNil(view._systemImage())
    }
    #endif
}
