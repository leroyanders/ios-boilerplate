import SwiftUI

struct WelcomeCommunicateSlideView: View {
	var body: some View {
		VStack(spacing: 16) {
			Image("communicate")
				.resizable()
				.scaledToFit()
			
			Text("Communicate")
				.font(.title)
				.fontWeight(.semibold)

			Text("Chat with people, ask questions, and discuss real professional cases")
				.fontWeight(Font.Weight.regular)
				.lineLimit(3)
				.foregroundStyle(.black.opacity(0.8))
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	WelcomeCommunicateSlideView()
}
