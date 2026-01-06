
import SwiftUI
struct RootView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            LoginView() // The app starts here
                .navigationDestination(for: String.self) { viewName in
                    if viewName == "RoleSelection" {
                        RoleSelectionView()
                    } else if viewName == "CustomerHome" {
                        CustomerMainView()
                    } else if viewName == "AdminHome" {
                        AdminMainView()
                    }
                }
        }
    }
}


