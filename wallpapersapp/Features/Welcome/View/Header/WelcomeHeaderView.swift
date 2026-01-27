import SwiftUI

struct WelcomeHeaderView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
				AppTitleName().padding(.bottom, 10)
				
                Text("Connect with people\nwho grow with you")
                    .font(.title)
                    .fontWeight(.semibold)
					.multilineTextAlignment(.leading)

                Text("A social space for communication and\nprofessional advice")
                    .foregroundStyle(.black.opacity(0.7))
					.padding(.top, 10)
					.multilineTextAlignment(.leading)
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
