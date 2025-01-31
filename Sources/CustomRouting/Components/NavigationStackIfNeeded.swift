import SwiftUI

struct NavigationStackIfNeeded<Content: View>: View {
    
    @Binding var path: [AnyDestination]
    var addNavigationView: Bool
    @ViewBuilder var content: Content
    
    var body: some View {
        if addNavigationView {
            NavigationStack(path: $path) {
                content
                    .navigationDestination(for: AnyDestination.self) { value in
                        value.destination
                    }
            }
        } else {
            content
        }
    }
}
