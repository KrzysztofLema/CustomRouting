import SwiftUI

extension Binding where Value == Bool {
    init<T: Sendable>(ifNotNil: Binding<T?>) {
        self.init {
            ifNotNil.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                ifNotNil.wrappedValue = nil
            }
        }
    }
}
