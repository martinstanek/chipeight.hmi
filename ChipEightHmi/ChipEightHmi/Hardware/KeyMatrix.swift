import Foundation
import SwiftUI
public import Combine

public final class KeyMatrix: NSObject, ObservableObject
{
    @Published public var keys: [Bool] = Array(repeating: false,count: 16)
    @Published public var lastPressed: UInt8?
    
    public func keyDown(key: String)
    {
        var index = Essentials.hexStringToBytes(string: key)[0]
        
        print("Key down: \(index)")
    }
    
    public func keyUp(key: String)
    {
        var index = Essentials.hexStringToBytes(string: key)[0]
        
        print("Key up: \(index)")
    }
}
