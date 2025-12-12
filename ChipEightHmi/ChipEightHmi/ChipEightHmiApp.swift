import SwiftUI

@main
struct ChipEightHmiApp: App
{
    @StateObject private var display = PixelDisplay()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(display)
        }
        .commands
        {
            CommandMenu("Display")
            {
                Button("Clear")
                {
                    display.clearDisplay()
                }
                .keyboardShortcut("k", modifiers: .command)
                
                Button("Light")
                {
                    display.ligthDisplay()
                }
                .keyboardShortcut("l", modifiers: .command)
                
                Button("Calibrate")
                {
                    display.calibrate()
                }
                .keyboardShortcut("b", modifiers: .command)
            }
        }
    }
}
