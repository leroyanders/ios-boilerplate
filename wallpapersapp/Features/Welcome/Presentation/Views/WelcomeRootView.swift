import SwiftUI
import Foundation

struct WelcomeRootView: View {
	@State private var page = 0
	
	var body: some View {
		NavigationStack {
			VStack {
				VStack(alignment: .leading) {
					WelcomeHeaderView()
					
					Spacer(minLength: 0)
					
					WelcomeSliderView(page: $page)
				}
				.padding(25)
			}
			.safeAreaInset(edge: .bottom) {
				WelcomeBottomBarView()
			}
		}
	}
}

#Preview {
	WelcomeRootView().environment(AuthViewModel())
}
