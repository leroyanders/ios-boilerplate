import SwiftUI

struct DiscoveryScreenView: View {
	@Environment(AuthViewModel.self) private var model
	
	var body: some View {
		VStack {
			Text("Discovery Screen")
				.navigationBarTitle("Discovery")
				.navigationBarItems(trailing: Button("Settings") { })
			
			Button("Sign Out") {
				model.logout()
			}
		}
	}
}

#Preview {
	DiscoveryScreenView()
}
