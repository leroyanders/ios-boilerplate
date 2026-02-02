import SwiftUI

struct AppRoot: View {
	@Environment(AuthViewModel.self) private var authViewModel
	@State private var isCheckingSession = true

	var body: some View {
		Group {
			if isCheckingSession {
				loadingView
			} else if authViewModel.user == nil {
				WelcomeRootView()
			} else {
				DiscoveryRootView()
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
				.progressViewStyle(.circular)
				.scaleEffect(1.2)
		}
	}

	private func checkSessionIfNeeded() async {
		guard isCheckingSession else { return }

		try? await Task.sleep(for: .milliseconds(300))
		await authViewModel.tryAutoLogin()
		isCheckingSession = false
	}
}

#Preview {
	let repository = FirebaseAuthRepository(
		authRemote: AuthRemoteService(),
		userRemote: UserRemoteStore(),
		userLocal: UserLocalStore(),
		avatarRemote: AvatarRemoteStore()
	)

	let useCase = AuthUseCase(repository: repository)
	let vm = AuthViewModel(useCase: useCase)

	AppRoot()
		.environment(vm)
}
