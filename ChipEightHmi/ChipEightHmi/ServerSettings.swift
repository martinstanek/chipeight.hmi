import Foundation
internal import Combine

@MainActor
final class ServerSettings: ObservableObject
{
    var objectWillChange: ObservableObjectPublisher?
    
    @Published var serverURL: String
    
    private static let serverURLKey = "serverURL"
    private static let defaultServerURL = "http://localhost:8090"
    
    init()
    {
        let savedURL = UserDefaults.standard.string(forKey: Self.serverURLKey)
        self.serverURL = savedURL ?? Self.defaultServerURL
    }
    
    func save()
    {
        UserDefaults.standard.set(serverURL, forKey: Self.serverURLKey)
    }
    
    func reset()
    {
        serverURL = Self.defaultServerURL
        save()
    }
}
