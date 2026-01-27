import SwiftUI

struct AppRoot: View {
	@State private var authViewModel = AuthViewModel()
	@State private var isCheckingSession = true

	var body: some View {
		Group {
			if isCheckingSession {
				ProgressView("Loading...")
			} else if authViewModel.user == nil {
				NavigationStack {
					WelcomeScreen()
				}
			} else {
				DiscoveryScreenView()
			}
		}
		.environment(authViewModel)
		.task {
			await authViewModel.tryAutoLogin()
			isCheckingSession = false
		}
	}
}


#Preview {
	AppRoot()
}
