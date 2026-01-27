import SwiftUI

struct AuthTextField: View {
	let placeholder: String
	let icon: String?
	let keyboardType: UIKeyboardType
	let textContentType: UITextContentType?
	
	@Binding var text: String
	@FocusState private var isFocused: Bool
	
	init(
		icon: String? = nil,
		placeholder: String,
		keyboardType: UIKeyboardType = .default,
		textContentType: UITextContentType? = nil,
		text: Binding<String>
	) {
		self.icon = icon
		self.placeholder = placeholder
		self.keyboardType = keyboardType
		self.textContentType = textContentType
		self._text = text
	}
	
	var body: some View {
		ZStack {
			// Background with tap gesture
			RoundedRectangle(cornerRadius: 14)
				.fill(Color.gray.opacity(0.1))
				.frame(height: 50)
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
				
				TextField(placeholder, text: $text)
					.textInputAutocapitalization(.never)
					.autocorrectionDisabled(true)
					.keyboardType(keyboardType)
					.textContentType(textContentType)
					.focused($isFocused)
					.frame(maxWidth: .infinity)
					.submitLabel(.next)
			}
			.padding(.horizontal, 16)
		}
		.frame(height: 50)
	}
}
