import SwiftUI

struct WelcomeConnectSlideView: View {
	@Environment(\.colorScheme) private var scheme

	var body: some View {
		VStack(spacing: 16) {
			Image("connect").resizable().scaledToFit()

			Text("Connect")
				.font(.title)
				.fontWeight(.semibold)
				.foregroundStyle(Color.appPrimary(scheme))

			Text("A place to talk, learn, and support each other")
				.foregroundStyle(Color.appSecondary(scheme))
				.multilineTextAlignment(.center)
		}
	}
}


#Preview {
	WelcomeConnectSlideView()
}
