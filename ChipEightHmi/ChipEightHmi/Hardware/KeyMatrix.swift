import Foundation
import SwiftUI
public import Combine

public final class KeyMatrix: NSObject, ObservableObject
{
    @Published public var keys: [Bool] = Array(repeating: false,count: 16)
    @Published public var lastPressed: UInt8?
    
    private let keysLock = NSLock()
    
    public func setKey(k: Int)
    {
        keysLock.lock()
        
        defer
        {
            keysLock.unlock()
        }
        
        DispatchQueue.main.async
        {
            self.keys[k] = true
        }
    }
    
}
