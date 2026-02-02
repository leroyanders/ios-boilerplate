import SwiftUI

struct DiscoveryRootView: View {
	@Environment(AuthViewModel.self) private var model
	@Environment(\.colorScheme) private var schema
	
	@State private var selectedTab: DiscoveryMainTab = .discovery
	@State private var selectedTabDiscovery: DiscoveryTab = .discovery
	
	var body: some View {
		NavigationStack {
			TabView(selection: $selectedTab) {
				
					// MARK: - Create
				Tab("Create", systemImage: "plus", value: DiscoveryMainTab.create) {
					VStack {
						Text("Create")
					}
				}
				
					// MARK: - Discovery
				Tab("Discovery", systemImage: "house", value: DiscoveryMainTab.discovery) {
					VStack(spacing: 0) {
						TabView(selection: $selectedTabDiscovery) {
							
							Group {
								ScrollView {
									Text("Discovery")
								}
							}
							.tag(DiscoveryTab.discovery)
							
							Group {
								ScrollView {
									Text("Following")
								}
							}
							.tag(DiscoveryTab.following)
						}.tabViewStyle(.page(indexDisplayMode: .never))
					}
					.safeAreaInset(edge: .top) {
						DisoveryTopBar(
							selectedTab: $selectedTab,
							selectedTabDiscovery: $selectedTabDiscovery,
							userImage: model.user?.image
						)
					}
				}
				
					// MARK: - Search
				Tab("Search", systemImage: "magnifyingglass", value: DiscoveryMainTab.search) {
					Text("Search")
				}
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
	
	DiscoveryRootView()
		.environment(vm)
}
