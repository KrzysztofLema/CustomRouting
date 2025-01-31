import SwiftUI


public struct RouterView<Content: View>: View, Router {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var path: [AnyDestination] = .init()
    
    @State private var showSheet: AnyDestination? = nil
    @State private var showFullScreenCover: AnyDestination? = nil
    
    @State private var alert: AnyAppAlert? = nil
    @State private var alertOption: AlertType = .alert
    
    @State private var modalBackgroudColor: Color = Color.black.opacity(0.6)
    @State private var modalTransistion: AnyTransition = AnyTransition.opacity
    @State private var modal: AnyDestination? = nil

    //Binding to the view stack from previous Router
    @Binding var screenStack: [AnyDestination]
    
    var addNavigationView: Bool
    @ViewBuilder var content: (Router) -> Content
    
    public init(
        screenStack: (Binding<[AnyDestination]>)? = nil,
        addNavigationView: Bool = true,
        content: @escaping (Router) -> Content
    ) {
        self._screenStack = screenStack ?? .constant([])
        self.addNavigationView = addNavigationView
        self.content = content
    }
    
    public var body: some View {
        NavigationStackIfNeeded(path: $path, addNavigationView: addNavigationView) {
            content(self)
                .sheetViewModifier(screen: $showSheet)
                .fullScreenCoverViewModifier(screen: $showFullScreenCover )
                .showCustomAlert(type: alertOption, alert: $alert)
        }
        .modalViewModifier(
            backgroundColor: modalBackgroudColor,
            transition: modalTransistion,
            screen: $modal
        )
        .environment(\.router, self)
    }
    
    public func showScreen<T: View>(_ option: SequeOption, @ViewBuilder destination: @escaping (Router) -> T) {
        let screen = RouterView<T>(
            screenStack:option.shouldAddNewNavigationView ? nil : (screenStack.isEmpty ? $path : $screenStack),
            addNavigationView: option.shouldAddNewNavigationView ? true : false
        ) { newRouter in
            destination(newRouter)
        }
        let destination = AnyDestination(destination: screen)
        
        switch option {
        case .push:
            if screenStack.isEmpty {
                // This means we are in first RouterView
                path.append(destination)
            } else {
                // This means we are in secondary Router View
                screenStack.append(destination)
            }
        case .sheet:
            showSheet = destination
        case .fullScreenCover:
            showFullScreenCover = destination
        }
    }
    
    public func dismissScreen() {
        dismiss()
    }
    
    public func showAlert(_ option: AlertType, title: String, subtitle: String?, buttons: (@Sendable () -> AnyView)? = nil) {
        self.alertOption = option

        self.alert = AnyAppAlert(title: title, subtitle: subtitle, buttons: buttons)
    }
    
    public func dismissAlert() {
        alert = nil
    }
    
    public func showModal<T: View>(
        backgroundColor: Color ,
        transition: AnyTransition,
        @ViewBuilder destination: @escaping () -> T) {
        self.modalBackgroudColor = backgroundColor
        self.modalTransistion = transition
            
        let destination = AnyDestination(destination: destination())
        self.modal = destination
            
    }
    
    public func dismissModal() {
        modal = nil
    }
}
