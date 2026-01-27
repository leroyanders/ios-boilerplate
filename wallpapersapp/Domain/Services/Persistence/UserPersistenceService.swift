protocol UserPersistenceService {
    func save(user: AppUser) throws
    func loadUser() throws -> AppUser?
    func deleteUser() throws
}
