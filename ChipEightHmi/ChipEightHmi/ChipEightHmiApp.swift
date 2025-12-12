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
                .frame(minWidth: 840, maxWidth: 840, minHeight: 435, maxHeight: 435)
//                .navigationTitle("Chip8 HMI")
                .onAppear
                {
                    NSApplication.shared.mainWindow?.title = "Your Title"
                }
        }
        .windowResizability(.contentSize)
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
