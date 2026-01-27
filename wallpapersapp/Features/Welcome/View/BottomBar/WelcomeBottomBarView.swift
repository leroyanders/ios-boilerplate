import SwiftUI

struct WelcomeBottomBarView: View {
    var body: some View {
        VStack(alignment: .leading) {
			NavigationLink(destination: SignInScreenView()) {
				Text("Continue with email")
					.foregroundStyle(.white)
					.frame(maxWidth: .infinity)
					.padding()
					.background(.black.opacity(0.9))
					.clipShape(Capsule())
			}.padding(.bottom, 10)

            HStack {
                VStack(alignment: .leading) {
                    Text("Or continue using")
                        .font(.system(size: 12))
                    Text("Apple ID, Google")
                        .font(.system(size: 15, weight: .medium))
                }

                HStack {
					SocialAuthButton(icon: .system("apple.logo"))
					SocialAuthButton(icon: .asset("google"))
					ShowMoreOptionsButton(icon: "ellipsis")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal, 25)
        .padding(.bottom, 10)
        .background(Color.white)
    }
}

#Preview {
	WelcomeBottomBarView()
}
