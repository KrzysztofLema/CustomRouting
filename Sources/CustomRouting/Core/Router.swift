import SwiftUI

public extension EnvironmentValues {
    @Entry var router: Router = MockRouter()
}

struct MockRouter: Router {
  
    func showScreen<T: View>(_ option: SequeOption, @ViewBuilder destination: @escaping (Router) -> T) {
        print("Mock Router does not work.")
    }
    
    func dismissScreen() {
        print("Mock Router does not work.")
    }
    
    func showAlert(_ option: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?) {
        print("Mock Router does not work.")
    }
    
    func dismissAlert() {
        print("Mock Router does not work.")
    }

    
    func dismissModal() {
        print("Mock Router does not work.")
    }
    
    func showModal<T>(backgroundColor: Color, transition: AnyTransition, destination: @escaping () -> T) where T : View {
        print("Mock Router does not work.")
    }
}

public protocol Router {
    func showScreen<T: View>(_ option: SequeOption, @ViewBuilder destination: @escaping (Router) -> T)
    func dismissScreen()
    func showAlert(_ option: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)?)
    func dismissAlert()
    func showModal<T: View>(backgroundColor: Color, transition: AnyTransition, @ViewBuilder destination: @escaping () -> T)
    func dismissModal()
}
