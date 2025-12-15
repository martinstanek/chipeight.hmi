import Foundation
import SwiftUI
public import Combine

public final class KeyMatrix: NSObject, ObservableObject
{
    @Published public var keys: [Bool] = Array(repeating: false, count: 16)
    @Published public var lastPressed: UInt8?
    @Published public var binaryArray: String = ""
    
    public func keyDown(key: String)
    {
        let index = Essentials.hexStringToBytes(string: key)[0]
        
        if keys[Int(index)]
        {
            return
        }
        
        keys[Int(index)] = true
        lastPressed = index
        binaryArray = Essentials.boolsToBinaryString(bools: keys)
        
        print("Key down: \(index)")
    }
    
    public func keyUp(key: String)
    {
        let index = Essentials.hexStringToBytes(string: key)[0]
        
        keys[Int(index)] = false
        binaryArray = Essentials.boolsToBinaryString(bools: keys)
        
        print("Key up: \(index)")
    }
}
