protocol TokenStorage {
    func save(token: String)
    func load() -> String?
    func delete()
}
