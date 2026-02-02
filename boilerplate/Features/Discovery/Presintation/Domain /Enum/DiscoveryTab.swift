enum DiscoveryTab: String, CaseIterable, Identifiable, Hashable {
	case discovery = "Discovery"
	case following = "Following"
	
	var id: String { rawValue }
}
