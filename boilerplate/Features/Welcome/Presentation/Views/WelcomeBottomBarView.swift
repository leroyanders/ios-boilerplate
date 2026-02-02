import SwiftUI

struct WelcomeBottomBarView: View {
	@Environment(\.colorScheme) private var scheme

	var body: some View {
		VStack(alignment: .leading) {
			NavigationLink(destination: AuthRootView()) {
				Text("Continue with email")
					.foregroundStyle(Color.appQuinary(scheme))
					.frame(maxWidth: .infinity)
					.padding()
					.background(Color.appPrimary(scheme))
					.clipShape(Capsule())
			}

			HStack {
				VStack(alignment: .leading) {
					Text("Or continue using")
						.foregroundStyle(Color.appSecondary(scheme))
					Text("Apple ID, Google")
						.foregroundStyle(Color.appPrimary(scheme))
				}
				
				Spacer()

				HStack {
					ButtonWithIcon(icon: .system("apple.logo")) {}
					ButtonWithIcon(icon: .asset("google")) {}
					ButtonWithIcon(icon: .system("ellipsis")) {}
				}
			}.padding(.top, 25)
		}
		.padding(.all, 25)
		.background(Color.appBackground(scheme))
	}
}

#Preview {
	WelcomeBottomBarView()
}
