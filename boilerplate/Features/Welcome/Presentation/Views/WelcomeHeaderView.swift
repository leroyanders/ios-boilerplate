import SwiftUI

struct WelcomeHeaderView: View {
	@Environment(\.colorScheme) private var scheme
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				AppTitleName()
					.padding(.bottom, 10)
				
				Text("Connect with people\nwho grow with you")
					.font(.title)
					.fontWeight(.semibold)
					.multilineTextAlignment(.leading)
					.foregroundStyle(Color.appPrimary(scheme))

				Text("A social space for communication and\nprofessional advice")
					.multilineTextAlignment(.leading)
					.padding(.top, 10)
					.foregroundStyle(Color.appSecondary(scheme))
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.top, 10)
			.padding(.bottom, 30)
		}
	}
}

#Preview {
	WelcomeHeaderView()
}
