import Foundation
import SwiftUI
import SwiftySound
public import Combine

public final class BeepGenerator: NSObject, ObservableObject
{
    @AppStorage("buzzerEnabled") private var enableBuzzer = true
    private var isSoundOn = false
    
    public func pitchOn()
    {
        if !enableBuzzer || isSoundOn
        {
            return
        }
        
        isSoundOn = true
        
        Sound.play(file: "440Hz.wav", numberOfLoops: -1)
    }
    
    public func pitchOff()
    {
        if !enableBuzzer || !isSoundOn
        {
            return
        }
        
        isSoundOn = false
        
        Sound.stopAll()
    }
    
    public func reset()
    {
        isSoundOn = false;
        Sound.stopAll()
    }
}
