import FlyingFox

public final class CommandServer
{
    private let server = HTTPServer(port: 8090)
    
    public func start(pixelDisplay: PixelDisplay) async throws
    {
        await server.appendRoute("/clear", to: ClearDisplayHandler(pixelDisplay: pixelDisplay))
        
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
    var display: PixelDisplay?
    
    init(pixelDisplay: PixelDisplay)
    {
        display = pixelDisplay
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        if (display != nil)
        {
            await display?.clearDisplay()
        }
        
        return HTTPResponse(statusCode: .ok)
    }
}
