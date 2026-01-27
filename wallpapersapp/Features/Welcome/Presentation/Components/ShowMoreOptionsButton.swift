import SwiftUI

struct ShowMoreOptionsButton: View {
	let icon: String

	var body: some View {
		Menu {
			Button("Ask a Question", systemImage: "questionmark.circle") {
				print("Ask a Question")
			}

			Button("FAQ", systemImage: "doc.text") {
				print("FAQ")
			}
		} label: {
			Image(systemName: icon)
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
	ShowMoreOptionsButton(icon: "ellipsis")
}
