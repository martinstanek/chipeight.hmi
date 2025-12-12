import Foundation
import SwiftUI
public import Combine

public final class PixelDisplay: NSObject, ObservableObject
{
    @Published public var pixels: [[Bool]] = Array(repeating: Array(repeating: false,count: DisplayConfig.width),count: DisplayConfig.height)
    @Published public var foregroundColor: Color = .red
    @Published public var backgroundColor: Color = .black
    
    private let pixelsLock = NSLock()
    
    public func clearDisplay()
    {
        setAllDisplay(state: false)
    }
    
    public func ligthDisplay()
    {
        setAllDisplay(state: true)
    }
    
    public func calibrate()
    {
        setPixel(x: 0, y: 0, state: true)
        setPixel(x: DisplayConfig.width - 1, y: 0, state: true)
        setPixel(x: 0, y: DisplayConfig.height - 1, state: true)
        setPixel(x: DisplayConfig.width - 1, y: DisplayConfig.height - 1, state: true)
    }
    
    public func setPixel(x: Int, y: Int, state: Bool)
    {
        pixelsLock.lock()
        
        defer
        {
            pixelsLock.unlock()
        }
        
        DispatchQueue.main.async
        {
            self.pixels[y][x] = state
        }
    }
    
    public func drawSprite(x: Int, y: Int, sprites: [UInt8])
    {
        pixelsLock.lock()
        
        defer
        {
            pixelsLock.unlock()
        }
        
        DispatchQueue.main.async
        {
            for (spriteIndex, sprite) in sprites.enumerated()
            {
                let pixels = self.byteToBools(byte: sprite)
                
                for (pixelIndex, pixel) in pixels.enumerated()
                {
                    self.pixels[y + spriteIndex][x + pixelIndex] = pixel
                }
            }
        }
    }
    
    private func setAllDisplay(state: Bool)
    {
        pixelsLock.lock()
        
        defer
        {
            pixelsLock.unlock()
        }
        
        DispatchQueue.main.async
        {
            self.pixels = Array(repeating: Array(repeating: state, count: DisplayConfig.width), count: DisplayConfig.height)
        }
    }
    
    private func byteToBools(byte: UInt8) -> [Bool]
    {
        (0..<8).reversed().map
        {
            bit in (byte & (1 << bit)) != 0
        }
    }
}
