import SwiftUI
import PhotosUI

struct AuthHeaderView: View {
	var authFlow: AuthFlowEnum? = .signIn
	@Binding var avatar: UIImage?
	@Environment(\.colorScheme) private var scheme
	
	var body: some View {
		VStack(alignment: .center) {
			if authFlow == .signUp {
				AuthAvatarPicker(avatarImage: $avatar)
					.padding()
			} else {
				Text("Grow together!")
					.font(.title)
					.fontWeight(.semibold)
					.multilineTextAlignment(.center)
					.foregroundStyle(Color.appPrimary(scheme))
			}
			
			Text("Join a community where people share experience and support each other.")
				.padding(.top, 10)
				.multilineTextAlignment(strategy: .writingDirectionBased)
				.multilineTextAlignment(.center)
				.foregroundStyle(Color.appSecondary(scheme))
		}
		.padding(.top, 15)
		.padding(.bottom, 25)
	}
}

#Preview {
	@Previewable @State var avatar: UIImage? = nil

	AuthHeaderView(
		authFlow: .signIn,
		avatar: $avatar
	)
}
