import Foundation
import SwiftUI
public import Combine

public final class KeyMatrix: NSObject, ObservableObject
{
    @Published public var keys: [Bool] = Array(repeating: false, count: 16)
    @Published public var lastPressed: UInt8?
    @Published public var binaryArray: String = "0000000000000000"
    @Published public var lastPressedHex: String = "XX"
    
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
        lastPressedHex = Essentials.bytesToHexString(bytes: [lastPressed!])
        
        print("Key down: \(index)")
    }
    
    public func keyUp(key: String)
    {
        let index = Essentials.hexStringToBytes(string: key)[0]
        
        keys[Int(index)] = false
        binaryArray = Essentials.boolsToBinaryString(bools: keys)
        
        print("Key up: \(index)")
    }
    
    public func ackLastKey()
    {
        lastPressed = nil
        lastPressedHex = "XX"
    }
    
    public func getStateString() -> String
    {
        return "\(lastPressedHex)\(binaryArray)"
    }
}
