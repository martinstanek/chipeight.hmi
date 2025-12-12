import Foundation
import SwiftUI
public import Combine

public class PixelDisplay: NSObject, ObservableObject
{
    @Published var pixels: [[Bool]] = Array(repeating: Array(repeating: false, count: DisplayConfig.width), count: DisplayConfig.height)
    @Published var foregroundColor: Color = .red
    @Published var backgroundColor: Color = .black
    
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
}
