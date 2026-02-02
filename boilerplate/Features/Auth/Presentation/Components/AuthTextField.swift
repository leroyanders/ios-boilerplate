import SwiftUI

struct AuthTextField: View {
	let placeholder: String
	let icon: String?
	let keyboardType: UIKeyboardType
	let textContentType: UITextContentType?

	@Binding var text: String
	@FocusState private var isFocused: Bool
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

				TextField(
					"",
					text: $text,
					prompt: Text(placeholder)
						.foregroundStyle(Color.appSecondary(scheme))
				)
				.textFieldStyle(.plain)
				.foregroundStyle(Color.appPrimary(scheme))
				.keyboardType(keyboardType)
				.textContentType(textContentType)
				.textInputAutocapitalization(.never)
				.autocorrectionDisabled(true)
				.focused($isFocused)
			}
			.padding(.horizontal, 16)
		}
	}
}
