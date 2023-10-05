import SwiftUI

/// The appearance and behaviour of a page view.
///
/// To configure the style for a single ``PageView`` or for all page view instances in a view hierarchy, use the
/// ``SwiftUI/View/pageViewStyle(_:)`` modifier. You can specify one of the built-in page styles, like plain or scroll:
///
/// ```swift
/// PageViewExample()
///     .pageViewStyle(.scroll)
/// ```
/// Alternatively, you can create and apply a custom style.
///
/// ### Custom Styles
/// To create a custom style, declare a type that conforms to the `PageViewStyle` protocol and implement
///  the required ``PageViewStyle/makeBody(configuration:)`` method. For example, here's how
///  the plain style is implemented:
///
///  ```swift
/// public struct PlainPageViewStyle: PageViewStyle {
///
///     public init() { }
///
///     public func makeBody(configuration: Configuration) -> some View {
///         ZStack {
///             configuration.content(configuration.selection.wrappedValue)
///         }
///     }
/// }
/// ```
///
/// Inside the method, use the configuration parameter, which is an instance of the
/// ``PageViewStyleConfiguration`` structure, to get the page content and a binding to the selected state.
public protocol PageViewStyle: DynamicProperty {
    
    associatedtype Body : View
    
    typealias Configuration = PageViewStyleConfiguration

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

}

struct PageViewStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        PageViewBasicExample()
    }
}
