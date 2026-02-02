import SwiftUI

struct AppTitleName: View {
	var body: some View {
		Text(AppEnvironment.appName)
			.fontWeight(.bold)
	}
}
