import Foundation
import SwiftUI
internal import Combine

class PixelDisplay: NSObject, ObservableObject
{
    @Published var pixels: [[Bool]] = Array(repeating: Array(repeating: false, count: 64), count: 32)
    @Published var foregroundColor: Color = .white
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
    
    private func setAllDisplay(state: Bool)
    {
        pixelsLock.lock()
        
        defer
        {
            pixelsLock.unlock()
        }
        
        DispatchQueue.main.async
        {
            self.pixels = Array(repeating: Array(repeating: state, count: 64), count: 32)
        }
    }
}
