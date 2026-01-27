import SwiftUI

struct AppRoot: View {
	@State private var authViewModel = AuthViewModel()
	@State private var isCheckingSession = true
	
	var body: some View {
		Group {
			if isCheckingSession {
				loadingView
			} else if authViewModel.user == nil {
				WelcomeRootView()
					.environment(authViewModel)
			} else {
				DiscoveryRootView()
					.environment(authViewModel)
			}
		}
		.task {
			await checkSessionIfNeeded()
		}
	}
	
	private var loadingView: some View {
		ZStack {
			Color(.systemBackground)
				.ignoresSafeArea()
			
			ProgressView("Loading")
				.progressViewStyle(CircularProgressViewStyle())
				.scaleEffect(1.2)
		}
	}
	
	private func checkSessionIfNeeded() async {
		guard isCheckingSession else { return }
		try? await Task.sleep(for: .milliseconds(300))
		
		await authViewModel.tryAutoLogin()
		await MainActor.run {
			isCheckingSession = false
		}
	}
}

#Preview {
	AppRoot()
}
