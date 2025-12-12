import FlyingFox

public final class CommandServer
{
    private let server = HTTPServer(port: 8090)
    
    public func start() async throws
    {
        try await server.run()
        try await server.waitUntilListening()
    }
    
    public func stop() async throws
    {
        await server.stop(timeout: 3)
    }
}

public final class ClearDisplayHandler : HTTPHandler
{
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        return HTTPResponse(statusCode: .ok)
    }
}
