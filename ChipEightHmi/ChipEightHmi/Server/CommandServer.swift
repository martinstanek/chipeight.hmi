import FlyingFox
import SwiftUI

public final class CommandServer
{
    @AppStorage("port") private var port = "8090"
    private lazy var server: HTTPServer = { getHttpServer() }()
    
    public func start(pixelDisplay: PixelDisplay, keyMatrix: KeyMatrix, buzzer: BeepGenerator) async throws
    {
        await server.appendRoute("/clear", to: ClearDisplayHandler(pixelDisplay: pixelDisplay))
        await server.appendRoute("/light", to: LightDisplayHandler(pixelDisplay: pixelDisplay))
        await server.appendRoute("/set/:x/:y/:on", to: SetPixelHandler(pixelDisplay: pixelDisplay))
        await server.appendRoute("/sprite/:x/:y/:sprites", to: DrawSpriteHandler(pixelDisplay: pixelDisplay))
        await server.appendRoute("/keys", to: GetKeysHandler(keyMatrix: keyMatrix))
        await server.appendRoute("/keys/ack", to: AckKeysHandler(keyMatrix: keyMatrix))
        await server.appendRoute("/buzzer/:on", to: BuzzerHandler(buzzer: buzzer))
        
        try await server.run()
        try await server.waitUntilListening()
    }
    
    public func stop() async
    {
        await server.stop(timeout: 3)
    }
    
    private func getHttpServer() -> HTTPServer
    {
        do
        {
            let p = UInt16(port) ?? 8090
            
            return HTTPServer(port: p)
        }
    }
}

internal final class ClearDisplayHandler : HTTPHandler
{
    private let display: PixelDisplay
    
    init(pixelDisplay: PixelDisplay)
    {
        display = pixelDisplay
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        await display.clearDisplay()
        
        return HTTPResponse(statusCode: .ok)
    }
}

internal final class LightDisplayHandler : HTTPHandler
{
    private let display: PixelDisplay
    
    init(pixelDisplay: PixelDisplay)
    {
        display = pixelDisplay
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        await display.ligthDisplay()
        
        return HTTPResponse(statusCode: .ok)
    }
}

internal final class SetPixelHandler : HTTPHandler
{
    private let display: PixelDisplay
    
    init(pixelDisplay: PixelDisplay)
    {
        display = pixelDisplay
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        let x = Int(request.routeParameters["x"] ?? "0") ?? 0
        let y = Int(request.routeParameters["y"] ?? "0") ?? 0
        let on = Bool(request.routeParameters["on"] ?? "false") ?? false
        
        await display.setPixel(x: x, y: y, state: on)
        
        return HTTPResponse(statusCode: .ok)
    }
}

internal final class DrawSpriteHandler : HTTPHandler
{
    private let display: PixelDisplay
    
    init(pixelDisplay: PixelDisplay)
    {
        display = pixelDisplay
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        let x = Int(request.routeParameters["x"] ?? "0") ?? 0
        let y = Int(request.routeParameters["y"] ?? "0") ?? 0
        let sprite = request.routeParameters["sprites"] ?? ""
        let spriteBytes = await Essentials.hexStringToBytes(string: sprite)
        
        await display.drawSprite(x: x, y: y, sprites: spriteBytes)
        
        return HTTPResponse(statusCode: .ok)
    }
}

internal final class GetKeysHandler : HTTPHandler
{
    private let keys: KeyMatrix
    
    init(keyMatrix: KeyMatrix)
    {
        keys = keyMatrix
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        let payload = await keys.getStateString().data(using: .utf8)
    
        return HTTPResponse(statusCode: .ok, headers: [:], body: HTTPBodySequence(data: Data(payload!)))
    }
}

internal final class AckKeysHandler : HTTPHandler
{
    private let keys: KeyMatrix
    
    init(keyMatrix: KeyMatrix)
    {
        keys = keyMatrix
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        await keys.ackLastKey()
    
        return HTTPResponse(statusCode: .ok)
    }
}

internal final class BuzzerHandler : HTTPHandler
{
    private let beeper: BeepGenerator
    
    init(buzzer: BeepGenerator)
    {
        beeper = buzzer
    }
    
    public func handleRequest(_ request: HTTPRequest) async throws -> HTTPResponse
    {
        let on = Bool(request.routeParameters["on"] ?? "false") ?? false
        
        if on
        {
            await beeper.pitchOn()
        }
        else
        {
            await beeper.pitchOff()
        }
    
        return HTTPResponse(statusCode: .ok)
    }
}
