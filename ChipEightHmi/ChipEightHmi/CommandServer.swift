import FlyingFox

public final class CommandServer
{
    private let server = HTTPServer(port: 8090)
    private let helloHandler = ClearDisplayHandler();
    
    public func start() async throws
    {
        await server.appendRoute("/hello", to: helloHandler)
        
        try await server.run()
        try await server.waitUntilListening()
    }
    
    public func stop() async
    {
        await server.stop(timeout: 3)
    }
}

internal final class ClearDisplayHandler : HTTPHandler
{
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        print("hello")
        return HTTPResponse(statusCode: .ok)
    }
}
