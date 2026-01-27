import SwiftUI

struct CloseSheetButton: View {
	var body: some View {
		Button {
			print("close")
		} label: {
			Image(systemName: "xmark")
				.font(.system(size: 14, weight: .semibold))
				.foregroundStyle(.gray)
				.padding(15)
				.background(.gray.opacity(0.1))
				.clipShape(Circle())
		}
	}
}

#Preview {
	CloseSheetButton()
}
