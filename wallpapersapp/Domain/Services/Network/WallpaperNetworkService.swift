protocol WallpaperNetworkService {
    func fetchWallpapers(query: String) async throws -> [Wallpaper]
}
