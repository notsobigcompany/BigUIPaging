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

/// The properties of a page view instance.
///
/// A configuration represents the properties of a page view, such as the current selection and next item.
/// You use a configuration as part of a ``PageViewStyle``.
public struct PageViewStyleConfiguration {
    
    /// A type erased value
    public struct Value: Hashable {
            
        let wrappedValue: any Hashable
        
        init(_ wrappedValue: any Hashable) {
            self.wrappedValue = wrappedValue
        }
        
        public static func == (lhs: PageViewStyleConfiguration.Value, rhs: PageViewStyleConfiguration.Value) -> Bool {
            lhs.wrappedValue.hashValue == rhs.wrappedValue.hashValue
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(wrappedValue)
        }
    }
    
    /// A type erased page
    public struct Page: View {
        
        let wrappedView: AnyView
        
        init<V>(_ view: V) where V: View {
            self.wrappedView = AnyView(view)
        }
        
        public var body: some View {
            wrappedView
        }
    }

    /// The current selection
    public var selection: Binding<Value>
    
    /// The next item relative to the given value
    public let next: (Value) -> Value?
    
    /// The previous item relative to the given value
    public let previous: (Value) -> Value?
    
    /// A page view for the given value
    public let content: (Value) -> Page
    
}

extension View {
    
    /// Sets the style of the page view within the current environment.
    public func pageViewStyle<S>(_ style: S) -> some View where S: PageViewStyle {
        self.environment(\.pageViewStyle, style)
    }
    
    /// Sets the orientation of the page view within the current environment.
    public func pageViewOrientation(_ axis: Axis) -> some View {
        self.environment(\.pageViewOrientation, axis)
    }
}

struct PageViewStyle_Previews: PreviewProvider {
    
    static var previews: some View {
        PageViewExamples()
    }
}
