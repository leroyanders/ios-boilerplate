import SwiftUI

enum ButtonIcon {
	case system(String)
	case asset(String)
}

struct ButtonWithIcon: View {
	let icon: ButtonIcon
	let width: CGFloat
	let height: CGFloat
	let action: () -> Void

	@Environment(\.colorScheme) private var scheme

	init(
		icon: ButtonIcon,
		width: CGFloat = 25,
		height: CGFloat = 25,
		action: @escaping () -> Void
	) {
		self.icon = icon
		self.width = width
		self.height = height
		self.action = action
	}

	var body: some View {
		Button {
			action()
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
			.frame(width: width, height: height)
			.foregroundStyle(Color.appPrimary(scheme))
			.padding(15)
			.background(Color.appLight(scheme))
			.clipShape(Circle())
		}
	}
}

#Preview {
	ButtonWithIcon(icon: .system("house")) {}
}
