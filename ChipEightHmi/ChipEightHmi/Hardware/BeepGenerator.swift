import Foundation
import SwiftUI
import SwiftySound
public import Combine

public final class BeepGenerator: NSObject, ObservableObject
{
    private var isSoundOn = false
    
    public func pitchOn()
    {
        if isSoundOn
        {
            return
        }
        
        Sound.play(file: "440Hz.wav", numberOfLoops: -1)
        
        isSoundOn = true
    }
    
    public func pitchOff()
    {
        isSoundOn = false
        
        Sound.stopAll()
    }
}
