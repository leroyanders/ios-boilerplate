import SwiftUI
import Foundation

struct WelcomeRootView: View {
	@State private var page = 0
	@Environment(\.colorScheme) private var scheme
	
	var body: some View {
		NavigationStack {
			VStack {
				VStack(alignment: .leading) {
					WelcomeHeaderView()
					
					Spacer(minLength: 0)
					
					WelcomeSliderView(page: $page)
				}
				.padding(25)
			}
			.background(Color.appBackground(scheme))
			.safeAreaInset(edge: .bottom) {
				WelcomeBottomBarView()
			}
		}
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

	WelcomeRootView()
		.environment(vm)
}
