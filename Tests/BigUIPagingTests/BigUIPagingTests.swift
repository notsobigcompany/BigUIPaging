import XCTest
import SwiftUI
@testable import BigUIPaging

final class BigUIPagingTests: XCTestCase {
    
    // MARK: - NSPageController
    
    #if os(macOS)
    func testArrangedObjects() {
        let pageView = PlatformPageView(
            selection: .constant(1),
            configuration: .init(
                transition: .scroll,
                orientation: .horizontal,
                spacing: 0
            )
        ) { value in
            value + 1
        } previous: { value in
            value - 1
        } content: { value in
            Text("\(value)")
        }
        
        let (objects, selectedIndex) = pageView.makeArrangedObjects(around: 5, limit: 2)
        guard let values = objects as? [Int] else {
            XCTFail()
            return
        }
        XCTAssertEqual(selectedIndex, 2)
        XCTAssertEqual(values.count, 5)
        XCTAssertEqual(values.first, 3)
        XCTAssertEqual(values.last, 7)
    }
    #endif
    
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
