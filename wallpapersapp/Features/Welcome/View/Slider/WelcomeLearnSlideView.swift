import SwiftUI

struct WelcomeLearnSlideView: View {
	var body: some View {
		VStack(spacing: 16) {
			Image("learn")
				.resizable()
				.scaledToFit()
			
			Text("Share & Learn")
				.font(.title)
				.fontWeight(.semibold)

			Text("Share your knowledge and get advice from experienced people")
				.fontWeight(Font.Weight.regular)
				.lineLimit(3)
				.foregroundStyle(.black.opacity(0.8))
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	WelcomeLearnSlideView()
}
