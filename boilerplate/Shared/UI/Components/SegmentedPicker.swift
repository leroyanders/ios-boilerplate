import SwiftUI

struct SegmentedPicker<T: CaseIterable & Identifiable & RawRepresentable & Equatable>: View
where T.RawValue == String {

	@Binding var selection: T
	private let items: [T]

	init(selection: Binding<T>, for type: T.Type) {
		self._selection = selection
		self.items = Array(type.allCases)
	}
	
	@Environment(\.colorScheme) private var scheme: ColorScheme

	var body: some View {
		HStack {
			ForEach(items) { item in
				Text(item.rawValue)
					.font(.system(size: 14, weight: .semibold))
					.foregroundStyle(.primary)
					.frame(maxWidth: .infinity)
					.padding(.vertical, 6)
					.contentShape(Rectangle())
					.onTapGesture {
						withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
							selection = item
						}
					}
			}
		}
		.padding(3)
		.background(
			ZStack(alignment: .leading) {
				RoundedRectangle(cornerRadius: 100)
					.fill(Color.white)

				GeometryReader { geo in
					let width = geo.size.width / CGFloat(items.count)

					RoundedRectangle(cornerRadius: 100)
						.fill(Color.appLight(scheme))
						.frame(width: width)
						.offset(x: width * CGFloat(index(of: selection)))
						.animation(.spring(response: 0.3, dampingFraction: 0.85), value: selection)
				}
			}
		)
		.padding(4)
		.overlay(
			RoundedRectangle(cornerRadius: 100)
				.stroke(Color.gray.opacity(0.4), lineWidth: 1)
		)
		.clipShape(RoundedRectangle(cornerRadius: 100))
	}

	private func index(of item: T) -> Int {
		items.firstIndex(of: item) ?? 0
	}
}
