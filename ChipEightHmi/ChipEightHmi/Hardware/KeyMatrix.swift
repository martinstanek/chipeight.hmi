import Foundation
import SwiftUI
public import Combine

public final class KeyMatrix: NSObject, ObservableObject
{
    @Published public var keys: [Bool] = Array(repeating: false, count: 16)
    @Published public var lastPressed: UInt8?
    
    public func keyDown(key: String)
    {
        let index = Essentials.hexStringToBytes(string: key)[0]
        
        if keys[Int(index)]
        {
            return
        }
        
        keys[Int(index)] = true
        lastPressed = index
        
        print("Key down: \(index)")
    }
    
    public func keyUp(key: String)
    {
        let index = Essentials.hexStringToBytes(string: key)[0]
        
        keys[Int(index)] = false
        
        print("Key up: \(index)")
    }
}
