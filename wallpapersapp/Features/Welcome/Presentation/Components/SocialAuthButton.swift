import SwiftUI

enum SocialIcon {
	case system(String)
	case asset(String)
}

struct SocialAuthButton: View {
	let icon: SocialIcon
	let action: (() -> Void)?

	init(icon: SocialIcon, action: (() -> Void)? = nil) {
		self.icon = icon
		self.action = action
	}

	var body: some View {
		Button {
			action?()
		} label: {
			Group {
				switch icon {
					case .system(let name):
						Image(systemName: name)
					case .asset(let name):
						Image(name)
							.resizable()
							.scaledToFit()
				}
			}
			.frame(width: 25, height: 25)
			.font(.system(size: 25, weight: .semibold))
			.foregroundStyle(.black)
			.padding(15)
			.background(.gray.opacity(0.1))
			.clipShape(Circle())
		}
	}
}

#Preview {
	SocialAuthButton(icon: .system("house"))
}
