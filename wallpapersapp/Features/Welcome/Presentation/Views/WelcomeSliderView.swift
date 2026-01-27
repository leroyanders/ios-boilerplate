import SwiftUI

struct WelcomeSliderView: View {
    @Binding var page: Int

	var body: some View {
		VStack {
			VStack {
				TabView(selection: $page) {
					WelcomeConnectSlideView().tag(0)
					WelcomeCommunicateSlideView().tag(1)
					WelcomeLearnSlideView().tag(2)
				}
				.frame(maxHeight: .infinity)
				.tabViewStyle(.page(indexDisplayMode: .never))
			}
			.padding(.vertical)
			.padding(.horizontal, 10)
			.background(
				RoundedRectangle(cornerRadius: 30)
					.fill(Color.gray.opacity(0.1))
			)
		}
		
		VStack {
			HStack {
				ForEach(0..<3) { index in
					Capsule()
						.fill(index == page
							  ? Color.black.opacity(0.8)
							  : Color.black.opacity(0.2))
						.frame(width: index == page ? 15 : 5, height: 5)
						.animation(.easeInOut, value: page)
				}
			}
			.padding(.top, 12)
		}.frame(maxWidth: .infinity, alignment: .center)
	}
}
