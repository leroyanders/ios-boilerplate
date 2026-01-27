import SwiftUI

struct AuthTextField: View {
	let placeholder: String
	
	var isSecure: Bool = false
	var icon: String? = nil
	var keyboardType: UIKeyboardType = .default
	var textContentType: UITextContentType? = nil
	
	@Binding var text: String
	@State private var isHidden: Bool = true
	
	init(
		icon: String? = nil,
		placeholder: String,
		isSecure: Bool = false,
		keyboardType: UIKeyboardType = .default,
		textContentType: UITextContentType? = nil,
		text: Binding<String>
	) {
		self.icon = icon
		self.placeholder = placeholder
		self.isSecure = isSecure
		self.keyboardType = keyboardType
		self.textContentType = textContentType
		self._text = text
	}
	
	var body: some View {
		HStack(spacing: 12) {
			if let icon = icon {
				Image(systemName: icon)
					.foregroundStyle(Color.primary)
					.frame(width: 30)
			}
			
			if isSecure {
				if isHidden {
					SecureField(placeholder, text: $text)
				} else {
					TextField(placeholder, text: $text)
				}
			} else {
				TextField(placeholder, text: $text)
					.textInputAutocapitalization(.never)
					.autocorrectionDisabled(true)
					.textContentType(textContentType)
					.keyboardType(keyboardType)
			}
			
			if isSecure {
				Button {
					isHidden.toggle()
				} label: {
					Image(systemName: isHidden ? "eye" : "eye.slash")
						.foregroundStyle(.gray)
				}
			}
		}
		.padding(.horizontal, 16)
		.frame(height: 50)
		.background(Color.gray.opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 14))
	}
}
