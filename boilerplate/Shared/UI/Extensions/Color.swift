import SwiftUI

extension Color {
	
		// MARK: - Raw palette (light base)
	
	private static let lightPrimary    = Color(.sRGB, red: 17/255,  green: 17/255,  blue: 17/255,  opacity: 1)
	private static let lightSecondary  = Color(.sRGB, red: 107/255, green: 114/255, blue: 128/255, opacity: 1)
	private static let lightTertiary   = Color(.sRGB, red: 209/255, green: 213/255, blue: 219/255, opacity: 1)
	private static let lightQuaternary = Color(.sRGB, red: 229/255, green: 231/255, blue: 235/255, opacity: 1)
	private static let lightQuinary    = Color(.sRGB, red: 243/255, green: 244/255, blue: 246/255, opacity: 1)
	
		// MARK: - Raw palette (dark base)
	
	private static let darkPrimary    = Color(.sRGB, red: 1,       green: 1,       blue: 1,       opacity: 1)
	private static let darkSecondary  = Color(.sRGB, red: 156/255, green: 163/255, blue: 175/255, opacity: 1)
	private static let darkTertiary   = Color(.sRGB, red: 75/255,  green: 85/255,  blue: 99/255,  opacity: 1)
	private static let darkQuaternary = Color(.sRGB, red: 31/255,  green: 41/255,  blue: 55/255,  opacity: 1)
	private static let darkQuinary    = Color(.sRGB, red: 17/255,  green: 24/255,  blue: 39/255,  opacity: 1)
	
		// MARK: - Dynamic semantic colors
	
	static func appPrimary(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? darkPrimary : lightPrimary
	}
	
	static func appSecondary(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? darkSecondary : lightSecondary
	}
	
	static func appTertiary(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? darkTertiary : lightTertiary
	}
	
	static func appQuaternary(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? darkQuaternary : lightQuaternary
	}
	
	static func appQuinary(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? darkQuinary : lightQuinary
	}
	
	static func appLight(_ scheme: ColorScheme) -> Color {
		scheme == .dark ? Color.appQuaternary(.light).opacity(0.1) : Color.appSecondary(.light).opacity(0.05)
	}
	
	static func appBackground(_ scheme: ColorScheme) -> Color {
		scheme == .dark
		? .black
		: .white
	}
}
