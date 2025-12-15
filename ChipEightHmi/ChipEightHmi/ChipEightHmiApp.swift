import SwiftUI

@main
struct ChipEightHmiApp: App
{
    @StateObject private var display = PixelDisplay()
    @State private var showSettings = false
    private let commandServer = CommandServer()
    @Environment(\.openWindow) private var openWindow
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(display)
                .frame(minWidth: 840, maxWidth: 840, minHeight: 435, maxHeight: 435)
                .onAppear
                {
                    tryStartServer(pixelDisplay: display)
                }
                .onDisappear
                {
                    tryStopServer()
                }
        }
        .windowResizability(.contentSize)
        .commands
        {
            CommandGroup(replacing: .appSettings)
            {
                Button("Settings...")
                {
                    openSettings()
                }
                .keyboardShortcut(",", modifiers: .command)
            }
            
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
        
        WindowGroup("Settings", id: "settings")
        {
            SettingsView()
                .frame(minWidth: 400, maxWidth: 400, minHeight: 250, maxHeight: 250)
        }
        .windowResizability(.contentSize)
    }
    
    private func tryStartServer(pixelDisplay: PixelDisplay)
    {
        Task
        {
            do
            {
                try await commandServer.start(pixelDisplay: pixelDisplay)
            }
            catch let error
            {
                print(error)
            }
            
        }
    }
    
    private func tryStopServer()
    {
        Task
        {
            await commandServer.stop();
        }
    }
    
    private func openSettings()
    {
        openWindow(id: "settings")
    }
}
