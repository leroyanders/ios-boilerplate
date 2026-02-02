import SwiftUI

struct WelcomeCommunicateSlideView: View {
	@Environment(\.colorScheme) private var scheme
	
	var body: some View {
		VStack(spacing: 16) {
			Image("communicate")
				.resizable()
				.scaledToFit()
			
			Text("Communicate")
				.font(.title)
				.fontWeight(.semibold)
				.foregroundStyle(Color.appPrimary(scheme))

			Text("Chat with people, ask questions, and discuss real professional cases")
				.fontWeight(.regular)
				.lineLimit(3)
				.foregroundStyle(Color.appSecondary(scheme))
				.multilineTextAlignment(.center)
		}
	}
}

#Preview {
	WelcomeCommunicateSlideView()
}
