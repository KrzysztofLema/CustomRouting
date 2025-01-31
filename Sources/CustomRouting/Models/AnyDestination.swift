import SwiftUI

public struct AnyDestination: Hashable {
    
    let id = UUID().uuidString
    
    var destination: AnyView
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: AnyDestination, rhs: AnyDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }
}
