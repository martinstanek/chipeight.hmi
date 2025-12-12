import SwiftUI

@main
struct ChipEightHmiApp: App
{
    @StateObject private var display = PixelDisplay()
    private let commandServer = CommandServer();
    
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
    
    private func tryStartServer()
    {
        Task
        {
            do
            {
                try await commandServer.start()
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
}
