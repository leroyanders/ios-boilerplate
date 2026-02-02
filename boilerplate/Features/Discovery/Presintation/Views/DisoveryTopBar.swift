import SwiftUI

struct DisoveryTopBar: View {
	@Binding var selectedTab: DiscoveryMainTab
	@Binding var selectedTabDiscovery: DiscoveryTab
	@Environment(\.colorScheme) private var scheme: ColorScheme
	
	var userImage: String?
	
	var body: some View {
		Group {
			VStack {
				HStack {
					AppTitleName()
					
				}.frame(maxWidth: .infinity, alignment: .center)
				
				HStack {
					HStack {
						ButtonWithIcon (icon: .system("pencil.tip.crop.circle"), width: 20, height: 20) {
							selectedTab = .create
						}
					}.frame(maxWidth: .infinity, alignment: .leading)
					
					HStack {
						SegmentedPicker(
							selection: $selectedTabDiscovery,
							for: DiscoveryTab.self
						)
						.frame(width: 200)
					}
					
					HStack {
						ButtonWithIcon (icon: .system("magnifyingglass"), width: 20, height: 20) {
							selectedTab = .search
						}
					}.frame(maxWidth: .infinity, alignment: .trailing)
				}
			}
		}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.horizontal, 25)
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
	
	DiscoveryRootView()
		.environment(vm)
}
