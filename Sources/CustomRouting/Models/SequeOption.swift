public enum SequeOption {
    case push, sheet, fullScreenCover
    
    var shouldAddNewNavigationView: Bool {
        switch self {
        case .fullScreenCover:
            return true
        case .push:
            return false
        case .sheet:
            return true
        }
    }
}
