import SwiftUI

struct WelcomeConnectSlideView: View {
	var body: some View {
		VStack(spacing: 16) {
			Image("connect")
				.resizable()
				.scaledToFit()
			
			Text("Connect")
				.font(.title)
				.fontWeight(.semibold)

			Text("A place to talk, learn, and support each other")
				.fontWeight(Font.Weight.regular)
				.lineLimit(3)
				.foregroundStyle(.black.opacity(0.8))
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	WelcomeConnectSlideView()
}
