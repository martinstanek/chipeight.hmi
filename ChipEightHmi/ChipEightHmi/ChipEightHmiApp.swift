import SwiftUI

@main
struct ChipEightHmiApp: App
{
    @Environment(\.openWindow) private var openWindow
    @StateObject private var display = PixelDisplay()
    @StateObject private var keyMatrix = KeyMatrix()
    private let commandServer = CommandServer()

    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(display)
                .frame(minWidth: 840, maxWidth: 840, minHeight: 435, maxHeight: 435)
                .onAppear
                {
                    tryStartServer()
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
                    openOrWindow(title: "Settings", id: "settings")
                }
                .keyboardShortcut(",", modifiers: .command)
            }
            
            CommandMenu("Display")
            {
                Button("Clear")
                {
                    display.clearDisplay()
                }
                .keyboardShortcut("r", modifiers: .command)
                
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
            
            CommandMenu("Keyboard")
            {
                Button("Show")
                {
                    openOrWindow(title: "Keyboard", id: "keyboard")
                }
                .keyboardShortcut("k", modifiers: .command)
                Button("Reset")
                {
                    keyMatrix.reset()
                }
                .keyboardShortcut("r", modifiers: .command)
            }
        }
        
        WindowGroup("Settings", id: "settings")
        {
            SettingsView()
                .frame(minWidth: 400, maxWidth: 400, minHeight: 250, maxHeight: 250)
        }
        .windowResizability(.contentSize)
        
        WindowGroup("Keyboard", id: "keyboard")
        {
            KeyboardView(keyMatrix: keyMatrix)
                .frame(minWidth: 300, maxWidth: 300, minHeight: 350, maxHeight: 350)
        }
        .windowResizability(.contentSize)
    }
    
    private func tryStartServer()
    {
        Task
        {
            do
            {
                try await commandServer.start(pixelDisplay: display, keyMatrix: keyMatrix)
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
    
    private func openOrWindow(title: String, id: String)
    {
        if let window = NSApp.windows.first(where: { $0.title == title })
        {
            window.makeKeyAndOrderFront(nil)
        }
        else
        {
            openWindow(id: id)
        }
    }
}
