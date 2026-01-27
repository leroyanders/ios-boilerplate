import SwiftUI
import PhotosUI

struct AuthHeaderView: View {
	var authFlow: AuthFlowEnum? = .signIn
	@Binding var avatar: UIImage?
	
	var body: some View {
		VStack(alignment: .center) {
			if authFlow == .signUp {
				AuthAvatarPicker(avatarImage: $avatar).padding()
			}
			
			Text(authFlow == .signIn ? "Grow together!" : "Let's get started!")
				.font(.title)
				.fontWeight(.semibold)
				.multilineTextAlignment(.center)
			
			Text("Join a community where people share experience and support each other.")
				.foregroundStyle(.black.opacity(0.7))
				.padding(.top, 10)
				.multilineTextAlignment(strategy: .writingDirectionBased)
				.multilineTextAlignment(.center)
		}
		.padding(.top, 10)
		.padding(.bottom, 30)
	}
}

#Preview {
	@Previewable @State var avatar: UIImage? = nil

	AuthHeaderView(
		authFlow: .signIn,
		avatar: $avatar
	)
}


