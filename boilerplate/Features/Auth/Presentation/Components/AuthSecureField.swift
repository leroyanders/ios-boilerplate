import SwiftUI

struct AuthSecureField: View {
	let placeholder: String
	let icon: String?

	@Binding var text: String
	@FocusState private var isFocused: Bool
	@State private var isHidden = true
	@Environment(\.colorScheme) private var scheme

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 14)
				.fill(Color.appLight(scheme))
				.frame(height: 50)
				.onTapGesture { isFocused = true }

			HStack(spacing: 12) {
				if let icon {
					Image(systemName: icon)
						.foregroundStyle(
							isFocused ? .blue : Color.appSecondary(scheme)
						)
						.frame(width: 30)
				}

				Group {
					if isHidden {
						SecureField(
							"",
							text: $text,
							prompt: Text(placeholder)
								.foregroundStyle(Color.appSecondary(scheme))
						)
					} else {
						TextField(
							"",
							text: $text,
							prompt: Text(placeholder)
								.foregroundStyle(Color.appSecondary(scheme))
						)
					}
				}
				.textFieldStyle(.plain)
				.foregroundStyle(Color.appPrimary(scheme))
				.textInputAutocapitalization(.never)
				.autocorrectionDisabled(true)
				.focused($isFocused)

				Button {
					isHidden.toggle()
				} label: {
					Image(systemName: isHidden ? "eye" : "eye.slash")
						.foregroundStyle(Color.appSecondary(scheme))
				}
				.buttonStyle(.plain)
			}
			.padding(.horizontal, 16)
		}
		.frame(height: 50)
	}
}
