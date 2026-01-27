import SwiftUI

struct AppRoot: View {
	@State private var authViewModel = AuthViewModel()
	@State private var isCheckingSession = true

	var body: some View {
		Group {
			if isCheckingSession {
				ProgressView("Loading").progressViewStyle(.circular)
			} else if authViewModel.user == nil {
				NavigationStack {
					WelcomeRootView()
				}
			} else {
				DiscoveryScreenView()
			}
		}
		.environment(authViewModel)
		.task {
			await checkSessionIfNeeded()
		}
	}

	private func checkSessionIfNeeded() async {
		guard isCheckingSession else { return }
		await authViewModel.tryAutoLogin()
		
		isCheckingSession = false
	}
}

#Preview {
	AppRoot()
}
