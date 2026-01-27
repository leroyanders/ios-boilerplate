import SwiftUI

struct AuthSecureField: View {
	let placeholder: String
	let icon: String?

	@Binding var text: String
	@FocusState private var isFocused: Bool
	@State private var isHidden: Bool = true

	init(icon: String? = nil, placeholder: String, text: Binding<String>) {
		self.icon = icon
		self.placeholder = placeholder
		self._text = text
	}

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 14, style: .continuous)
				.fill(Color.gray.opacity(0.1))
				.contentShape(Rectangle())
				.onTapGesture {
					isFocused = true
				}

			HStack(spacing: 12) {
				if let icon {
					Image(systemName: icon)
						.foregroundStyle(isFocused ? .blue : .primary)
						.frame(width: 30)
				}

				ZStack {
					if isHidden {
						SecureField(placeholder, text: $text)
							.textInputAutocapitalization(.never)
							.autocorrectionDisabled(true)
							.textContentType(.password)
							.focused($isFocused)
					} else {
						TextField(placeholder, text: $text)
							.textInputAutocapitalization(.never)
							.autocorrectionDisabled(true)
							.textContentType(.password)
							.focused($isFocused)
					}
				}
				.submitLabel(.done)
				.frame(maxWidth: .infinity)

				Button {
					withAnimation(.easeInOut(duration: 0.15)) {
						isHidden.toggle()
					}
				} label: {
					Image(systemName: isHidden ? "eye" : "eye.slash")
						.foregroundStyle(isFocused ? .blue : .gray)
						.font(.system(size: 18))
				}
				.buttonStyle(.plain)
			}
			.padding(.horizontal, 16)
		}
		.frame(height: 50)
	}
}
