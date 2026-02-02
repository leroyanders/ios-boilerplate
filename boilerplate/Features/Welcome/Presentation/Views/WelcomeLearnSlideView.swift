import SwiftUI

struct WelcomeLearnSlideView: View {
	@Environment(\.colorScheme) private var scheme
	
	var body: some View {
		VStack(spacing: 16) {
			Image("learn")
				.resizable()
				.scaledToFit()
			
			Text("Share & Learn")
				.font(.title)
				.fontWeight(.semibold)
				.foregroundStyle(Color.appPrimary(scheme))

			Text("Share your knowledge and get advice from experienced people")
				.fontWeight(.regular)
				.lineLimit(3)
				.foregroundStyle(Color.appSecondary(scheme))
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	WelcomeLearnSlideView()
}
